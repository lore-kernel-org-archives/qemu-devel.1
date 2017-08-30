Received: from eggs.gnu.org ([2001:4830:134:3::10]:50856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn60E-0008KE-3e
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn609-000720-64
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:38:06 -0400
Date: Wed, 30 Aug 2017 17:37:50 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830163750.GY24565@stefanha-x1.localdomain>
References: <20170822131832.20191-1-pbonzini@redhat.com>
	<20170822131832.20191-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170822131832.20191-10-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/10] scsi: add multipath support to
 qemu-pr-helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org

On Tue, Aug 22, 2017 at 03:18:31PM +0200, Paolo Bonzini wrote:
> +static int multipath_pr_in(int fd, const uint8_t *cdb, uint8_t *sense,
> +                           uint8_t *data, int sz)
> +{
> +    int rq_servact = cdb[1];
> +    struct prin_resp resp;
> +    size_t written;
> +    int r;
> +
> +    switch (rq_servact) {
> +    case MPATH_PRIN_RKEY_SA:
> +    case MPATH_PRIN_RRES_SA:
> +    case MPATH_PRIN_RCAP_SA:
> +        break;
> +    case MPATH_PRIN_RFSTAT_SA:
> +        /* Nobody implements it anyway, so bail out. */
> +    default:
> +        /* Cannot parse any other output.  */
> +        scsi_build_sense(sense, SENSE_CODE(INVALID_FIELD));
> +        return CHECK_CONDITION;
> +    }
> +
> +    r = mpath_persistent_reserve_in(fd, rq_servact, &resp, noisy, verbose);
> +    if (r == MPATH_PR_SUCCESS) {
> +        switch (rq_servact) {

The case statements asssume sz has a certain minimum value.  I didn't
see a check anywhere that guarantees this.  It may be easier to hide the
client's sz value and instead use sizeof(client->data).  The caller can
worry about sz.

> +        case MPATH_PRIN_RKEY_SA:
> +        case MPATH_PRIN_RRES_SA: {
> +            struct prin_readdescr *out = &resp.prin_descriptor.prin_readkeys;
> +            stl_be_p(&data[0], out->prgeneration);
> +            stl_be_p(&data[4], out->additional_length);
> +            memcpy(&data[8], out->key_list, MIN(out->additional_length, sz - 8));

sz < 8 is possible, please handle this case.

> +            written = MIN(out->additional_length + 8, sz);
> +            break;
> +        }
> +        case MPATH_PRIN_RCAP_SA: {
> +            struct prin_capdescr *out = &resp.prin_descriptor.prin_readcap;
> +            stw_be_p(&data[0], out->length);
> +            data[2] = out->flags[0];
> +            data[3] = out->flags[1];
> +            stw_be_p(&data[4], out->pr_type_mask);
> +            written = MIN(6, sz);
> +            break;
> +        }
> +        default:
> +            scsi_build_sense(sense, SENSE_CODE(INVALID_OPCODE));
> +            return CHECK_CONDITION;
> +        }
> +        assert(written < sz);

Why is written == sz not allowed?

> +        memset(data + written, 0, sz - written);
> +    }
> +
> +    return mpath_reconstruct_sense(fd, r, sense);
> +}
> +
> +static int multipath_pr_out(int fd, const uint8_t *cdb, uint8_t *sense,
> +                            const uint8_t *param, int sz)
> +{
> +    int rq_servact = cdb[1];
> +    int rq_scope = cdb[2] >> 4;
> +    int rq_type = cdb[2] & 0xf;
> +    struct prout_param_descriptor paramp;
> +    char transportids[PR_HELPER_DATA_SIZE];
> +    int r;
> +    int i, j;
> +
> +    switch (rq_servact) {
> +    case MPATH_PROUT_REG_SA:
> +    case MPATH_PROUT_RES_SA:
> +    case MPATH_PROUT_REL_SA:
> +    case MPATH_PROUT_CLEAR_SA:
> +    case MPATH_PROUT_PREE_SA:
> +    case MPATH_PROUT_PREE_AB_SA:
> +    case MPATH_PROUT_REG_IGN_SA:
> +    case MPATH_PROUT_REG_MOV_SA:
> +        break;
> +    default:
> +        /* Cannot parse any other input.  */
> +        scsi_build_sense(sense, SENSE_CODE(INVALID_FIELD));
> +        return CHECK_CONDITION;
> +    }
> +
> +    /* Convert input data, especially transport IDs, to the structs
> +     * used by libmpathpersist (which, of course, will immediately
> +     * do the opposite).
> +     */
> +    memset(&paramp, 0, sizeof(paramp));
> +    memcpy(&paramp.key, &param[0], 8);
> +    memcpy(&paramp.sa_key, &param[8], 8);
> +    paramp.sa_flags = param[10];
> +    for (i = PR_OUT_FIXED_PARAM_SIZE, j = 0; i < sz; ) {
> +        struct transportid *id = (struct transportid *) &transportids[j];
> +        int len;
> +
> +        id->format_code = param[i] & 0xc0;
> +        id->protocol_id = param[i] & 0x0f;
> +        switch (param[i] & 0xcf) {

At this point we know sz > PR_OUT_FIXED_PARAM_SIZE && i < sz.  I think
the following case statements can read beyond the end of client->data[]
because nothing checks sz before accessing param[].

Missing sz checks?

> +        case 0:
> +            /* FC transport.  */
> +            memcpy(id->n_port_name, &param[i + 8], 8);
> +            j += offsetof(struct transportid, n_port_name[8]);
> +            i += 24;
> +            break;
> +        case 3:
> +        case 0x43:
> +            /* iSCSI transport.  */
> +            len = lduw_be_p(&param[i + 2]);
> +            if (len > 252 || (len & 3)) {

int len can be negative here :(.  Please use the size_t type - it's
unsigned and used by memchr(3)/memcpy(3).
