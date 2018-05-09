Received: from eggs.gnu.org ([2001:4830:134:3::10]:54359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGId6-0004bP-0M
	for qemu-devel@nongnu.org; Wed, 09 May 2018 02:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGId4-0002HH-R2
	for qemu-devel@nongnu.org; Wed, 09 May 2018 02:31:12 -0400
Date: Wed, 9 May 2018 14:30:51 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180509063051.GA30011@lemon.usersys.redhat.com>
References: <20180418030424.28980-1-famz@redhat.com>
	<20180418030424.28980-6-famz@redhat.com>
	<20180503102743.GD5301@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503102743.GD5301@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC PATCH v2 5/7] iscsi: Implement copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Thu, 05/03 11:27, Stefan Hajnoczi wrote:
> On Wed, Apr 18, 2018 at 11:04:22AM +0800, Fam Zheng wrote:
> > +static void iscsi_save_designator(IscsiLun *lun,
> > +                                  struct scsi_inquiry_device_identification *inq_di)
> > +{
> > +    struct scsi_inquiry_device_designator *desig, *copy = NULL;
> > +
> > +    for (desig = inq_di->designators; desig; desig = desig->next) {
> > +        if (desig->association ||
> > +            desig->designator_type > SCSI_DESIGNATOR_TYPE_NAA) {
> > +            continue;
> > +        }
> > +        /* NAA works better than T10 vendor ID based designator. */
> > +        if (!copy || copy->designator_type < desig->designator_type) {
> > +            copy = desig;
> > +        }
> > +    }
> > +    if (copy) {
> > +        lun->dd = g_new(struct scsi_inquiry_device_designator, 1);
> > +        *lun->dd = *copy;
> 
> Just in case:
> 
>   lun->dd->next = NULL;

Sure.

> 
> > +        lun->dd->designator = g_malloc(copy->designator_length);
> > +        memcpy(lun->dd->designator, copy->designator, copy->designator_length);
> > +    }
> > +}
> > +
> >  static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
> >                        Error **errp)
> >  {
> > @@ -1922,6 +1946,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
> >          struct scsi_task *inq_task;
> >          struct scsi_inquiry_logical_block_provisioning *inq_lbp;
> >          struct scsi_inquiry_block_limits *inq_bl;
> > +        struct scsi_inquiry_device_identification *inq_di;
> >          switch (inq_vpd->pages[i]) {
> >          case SCSI_INQUIRY_PAGECODE_LOGICAL_BLOCK_PROVISIONING:
> >              inq_task = iscsi_do_inquiry(iscsilun->iscsi, iscsilun->lun, 1,
> > @@ -1947,6 +1972,17 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
> >                     sizeof(struct scsi_inquiry_block_limits));
> >              scsi_free_scsi_task(inq_task);
> >              break;
> > +        case SCSI_INQUIRY_PAGECODE_DEVICE_IDENTIFICATION:
> 
> The device designator part should probably be a separate patch.

Good idea, I'll do the split.

> 
> > +            inq_task = iscsi_do_inquiry(iscsilun->iscsi, iscsilun->lun, 1,
> > +                                    SCSI_INQUIRY_PAGECODE_DEVICE_IDENTIFICATION,
> > +                                    (void **) &inq_di, errp);
> > +            if (inq_task == NULL) {
> > +                ret = -EINVAL;
> > +                goto out;
> > +            }
> > +            iscsi_save_designator(iscsilun, inq_di);
> > +            scsi_free_scsi_task(inq_task);
> > +            break;
> >          default:
> >              break;
> >          }
> > @@ -2003,6 +2039,8 @@ static void iscsi_close(BlockDriverState *bs)
> >          iscsi_logout_sync(iscsi);
> >      }
> >      iscsi_destroy_context(iscsi);
> > +    g_free(iscsilun->dd->designator);
> 
> Can iscsilun->dd be NULL?

Yes, if the INQUIRY response isn't typical. Will add an if here.

> 
> > +static void iscsi_xcopy_data(struct iscsi_data *data,
> > +                             IscsiLun *src, int64_t src_lba,
> > +                             IscsiLun *dst, int64_t dst_lba,
> > +                             int num_blocks)
> 
> It's not obvious that int is the appropriate type for num_blocks.  The
> caller had a uint64_t value.  Also, IscsiLun->num_blocks is uint64_t.

This is limited by the field size in the command data (2 bytes) so int is big
enough, although unsigned is better. I can change the type, add a comment and an
assert.

> 
> > +{
> > +    uint8_t *buf;
> > +    int offset;
> > +    int tgt_desc_len, seg_desc_len;
> > +
> > +    data->size = XCOPY_DESC_OFFSET +
> 
> struct iscsi_data->size is size_t.  Why does this function and the
> populate function use int for memory offsets/lengths?
> 
> > +                 32 * 2 +    /* IDENT_DESCR_TGT_DESCR */
> > +                 28;         /* BLK_TO_BLK_SEG_DESCR */
> > +    data->data = g_malloc0(data->size);
> > +    buf = data->data;
> > +
> > +    /* Initialise CSCD list with one src + one dst descriptor */
> > +    offset = XCOPY_DESC_OFFSET;
> > +    offset += iscsi_populate_target_desc(buf + offset, src);
> > +    offset += iscsi_populate_target_desc(buf + offset, dst);
> > +    tgt_desc_len = offset - XCOPY_DESC_OFFSET;
> > +
> > +    /* Initialise one segment descriptor */
> > +    seg_desc_len = iscsi_xcopy_populate_desc(buf + offset, 0, 0,
> > +                                             0, 1, num_blocks,
> > +                                             src_lba, dst_lba);
> > +    offset += seg_desc_len;
> > +
> > +    /* Initialise the parameter list header */
> > +    iscsi_xcopy_populate_header(buf, 1, 0, 2 /* LIST_ID_USAGE_DISCARD */,
> > +                                0, tgt_desc_len, seg_desc_len, 0);
> 
> offset, tgt_desc_len, and seg_desc_len are not necessary:
> 
> 1. We already hardcoded exact size for g_malloc0(), so why are we
>    calculating the size again dynamically?
> 
> 2. The populate functions assume the caller already knows the size
>    since there is no buffer length argument to prevent overflows.
> 
> It's cleaner to use hardcoded offsets:
> 
>   iscsi_xcopy_populate_header(buf, 1, 0, 2 /* LIST_ID_USAGE_DISCARD */,
>                               0, 2 * XCOPY_TGT_DESC_LEN,
> 			      XCOPY_SEG_DESC_LEN, 0);
>   iscsi_populate_target_desc(&buf[XCOPY_SRC_OFFSET], src);
>   iscsi_populate_target_desc(&buf[XCOPY_DST_OFFSET], dst);
>   iscsi_xcopy_populate_desc(&buf[XCOPY_SEG_OFFSET], 0, 0, 0, 1,
>                             num_blocks, src_lba, dst_lba);
> 
> Then the populate functions don't need to return sizes and we don't have
> to pretend that offsets are calculated dynamically.

The data types and offset calculation issues are all copyied from libiscsi
example, I'll clean up as you suggested. Thanks.

> 
> > +    while (!iscsi_task.complete) {
> > +        iscsi_set_events(dst_lun);
> > +        qemu_mutex_unlock(&dst_lun->mutex);
> > +        qemu_coroutine_yield();
> > +        qemu_mutex_lock(&dst_lun->mutex);
> > +    }
> 
> This code is duplicated several times already.  Please create a helper
> function as a separate patch before adding xcopy support:
> 
>   /* Yield until @iTask has completed */
>   static void coroutine_fn iscsi_co_wait_for_task(IscsiTask *iTask,
>                                                   IscsiLun *iscsilun);

Yes, will do.

Fam
