Received: from eggs.gnu.org ([2001:4830:134:3::10]:32826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1faHah-0003SB-1p
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1faHaf-0005zJ-O0
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:27:19 -0400
Received: from forwardcorp1o.cmail.yandex.net ([2a02:6b8:0:1a72::290]:54381)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dimastep@yandex-team.ru>)
	id 1faHaf-0005s0-6E
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:27:17 -0400
Date: Tue, 3 Jul 2018 12:27:11 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
Message-ID: <20180703092711.GA823@dimastep-nix>
References: <1529053904-12607-1-git-send-email-dimastep@yandex-team.ru>
	<20180702085207.GA6032@dimastep-nix>
	<5149995f-2bb2-cbe8-1a2c-e16ed0ee3cd6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5149995f-2bb2-cbe8-1a2c-e16ed0ee3cd6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1] qemu-pr-helper: garbage response
 structure can be used to write data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, wrfsh@yandex-team.ru

On Mon, Jul 02, 2018 at 02:21:41PM +0200, Paolo Bonzini wrote:
> On 02/07/2018 10:52, Dima Stepanov wrote:
> > Ping.
> > 
> > On Fri, Jun 15, 2018 at 12:11:44PM +0300, Dima Stepanov wrote:
> >> The prh_co_entry() routine handles requests. The first part is to read a
> >> request by calling the prh_read_request() routine, if:
> >>   1. scsi_cdb_xfer(req->cdb) call returns 0, and
> >>   2. req->cdb[0] == PERSISTENT_RESERVE_IN, then
> >> The resp->result field will be uninitialized. As a result the resp.sz
> >> field will be also uninitialized in the prh_co_entry() function.
> >> The second part is to send the response by calling the
> >> prh_write_response() routine:
> >>   1. For the PERSISTENT_RESERVE_IN command, and
> >>   2. resp->result == GOOD (previous successful reply or just luck), then
> >> There is a probability that the following assert will not be trigered:
> >>   assert(resp->sz <= req->sz && resp->sz <= sizeof(client->data));
> >> As a result some uninitialized response will be sent.
> >>
> >> The fix is to initialize the response structure to CHECK_CONDITION and 0
> >> values before calling the prh_read_request() routine.
> 
> The actual bug is that the "if (sz > 0)" should apply only to 
> PERSISTENT_RESERVE_OUT, and in fact it can be done in do_pr_out.  
> PERSISTENT_RESERVE_IN with sz == 0 is weird but okay.
> 
> This simplifies the code a bit too, because we can handle closing the 
> file descriptor in prh_co_entry.
> 
> Does something like this work for you?

Thanks for the feedback. Yes, this will work for me. Should i update the
patch and resend it or you will just pick the version you suggested?

Regards, Dima.

> 
> diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
> index 0218d65bbf..c89a446a45 100644
> --- a/scsi/qemu-pr-helper.c
> +++ b/scsi/qemu-pr-helper.c
> @@ -455,6 +455,14 @@ static int multipath_pr_out(int fd, const uint8_t *cdb, uint8_t *sense,
>      char transportids[PR_HELPER_DATA_SIZE];
>      int r;
>  
> +    if (sz < PR_OUT_FIXED_PARAM_SIZE) {
> +        /* Illegal request, Parameter list length error.  This isn't fatal;
> +         * we have read the data, send an error without closing the socket.
> +         */
> +        scsi_build_sense(sense, SENSE_CODE(INVALID_PARAM_LEN));
> +        return CHECK_CONDITION;
> +    }
> +
>      switch (rq_servact) {
>      case MPATH_PROUT_REG_SA:
>      case MPATH_PROUT_RES_SA:
> @@ -574,6 +582,12 @@ static int do_pr_out(int fd, const uint8_t *cdb, uint8_t *sense,
>                       const uint8_t *param, int sz)
>  {
>      int resp_sz;
> +
> +    if ((fcntl(fd, F_GETFL) & O_ACCMODE) == O_RDONLY) {
> +        scsi_build_sense(sense, SENSE_CODE(INVALID_OPCODE));
> +        return CHECK_CONDITION;
> +    }
> +
>  #ifdef CONFIG_MPATH
>      if (is_mpath(fd)) {
>          return multipath_pr_out(fd, cdb, sense, param, sz);
> @@ -690,21 +704,6 @@ static int coroutine_fn prh_read_request(PRHelperClient *client,
>                                   errp) < 0) {
>              goto out_close;
>          }
> -        if ((fcntl(client->fd, F_GETFL) & O_ACCMODE) == O_RDONLY) {
> -            scsi_build_sense(resp->sense, SENSE_CODE(INVALID_OPCODE));
> -            sz = 0;
> -        } else if (sz < PR_OUT_FIXED_PARAM_SIZE) {
> -            /* Illegal request, Parameter list length error.  This isn't fatal;
> -             * we have read the data, send an error without closing the socket.
> -             */
> -            scsi_build_sense(resp->sense, SENSE_CODE(INVALID_PARAM_LEN));
> -            sz = 0;
> -        }
> -        if (sz == 0) {
> -            resp->result = CHECK_CONDITION;
> -            close(client->fd);
> -            client->fd = -1;
> -        }
>      }
>  
>      req->fd = client->fd;
> @@ -785,25 +784,23 @@ static void coroutine_fn prh_co_entry(void *opaque)
>              break;
>          }
>  
> -        if (sz > 0) {
> -            num_active_sockets++;
> -            if (req.cdb[0] == PERSISTENT_RESERVE_OUT) {
> -                r = do_pr_out(req.fd, req.cdb, resp.sense,
> -                              client->data, sz);
> -                resp.sz = 0;
> -            } else {
> -                resp.sz = sizeof(client->data);
> -                r = do_pr_in(req.fd, req.cdb, resp.sense,
> -                             client->data, &resp.sz);
> -                resp.sz = MIN(resp.sz, sz);
> -            }
> -            num_active_sockets--;
> -            close(req.fd);
> -            if (r == -1) {
> -                break;
> -            }
> -            resp.result = r;
> +        num_active_sockets++;
> +        if (req.cdb[0] == PERSISTENT_RESERVE_OUT) {
> +            r = do_pr_out(req.fd, req.cdb, resp.sense,
> +                          client->data, sz);
> +            resp.sz = 0;
> +        } else {
> +            resp.sz = sizeof(client->data);
> +            r = do_pr_in(req.fd, req.cdb, resp.sense,
> +                         client->data, &resp.sz);
> +            resp.sz = MIN(resp.sz, sz);
> +        }
> +        num_active_sockets--;
> +        close(req.fd);
> +        if (r == -1) {
> +            break;
>          }
> +        resp.result = r;
>  
>          if (prh_write_response(client, &req, &resp, &local_err) < 0) {
>              break;
