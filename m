Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A33AC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD49621BE5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCUhY7wo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD49621BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL53r-0006V4-OJ
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 09:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kL52h-0005W1-2C
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 09:42:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25032)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kL52f-0006c5-1v
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 09:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600868560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YjyHk4I0+qazNve6emUYCtmbXL1NPtzvqerjgKdpyVk=;
 b=cCUhY7wog9V1/QMD5cQ+Wif7zmKsMpm1Q6XHFEmlSJMxFoSJSEyy+LAdqlxDqxpAWXnx5e
 aDXeJEBMWOIEF+PL5ehbtP0Ap/7ea7p50bTWwJoGRApUYdg0qDvI98i6Vu3fIIB9rWfojr
 PiE1TOJ3UHV8Lqe+Ytum5NgyXT9jLZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-b5Fz9J0_O36EghwbWjgl_A-1; Wed, 23 Sep 2020 09:42:38 -0400
X-MC-Unique: b5Fz9J0_O36EghwbWjgl_A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 092EB8ECE53;
 Wed, 23 Sep 2020 13:42:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 510E975131;
 Wed, 23 Sep 2020 13:42:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D5CFE1132E9A; Wed, 23 Sep 2020 15:42:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 11/11] block/export: convert vhost-user-blk server to
 block export API
References: <20200922160401.294055-1-stefanha@redhat.com>
 <20200922160401.294055-12-stefanha@redhat.com>
Date: Wed, 23 Sep 2020 15:42:30 +0200
In-Reply-To: <20200922160401.294055-12-stefanha@redhat.com> (Stefan Hajnoczi's
 message of "Tue, 22 Sep 2020 17:04:01 +0100")
Message-ID: <87v9g44njt.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Hajnoczi <stefanha@redhat.com> writes:

> Use the new QAPI block exports API instead of defining our own QOM
> objects.
>
> This is a large change because the lifecycle of VuBlockDev needs to
> follow BlockExportDriver. QOM properties are replaced by QAPI options
> objects.
>
> VuBlockDev is renamed VuBlkExport and contains a BlockExport field.
> Several fields can be dropped since BlockExport already has equivalents.
>
> The file names and meson build integration will be adjusted in a future
> patch. libvhost-user should probably be built as a static library that
> is linked into QEMU instead of as a .c file that results in duplicate
> compilation.
>
> The new command-line syntax is:
>
>   $ qemu-storage-daemon \
>       --blockdev file,node-name=drive0,filename=test.img \
>       --export vhost-user-blk,node-name=drive0,id=export0,unix-socket=/tmp/vhost-user-blk.sock
>
> Note that unix-socket is optional because we may wish to accept chardevs
> too in the future.

It's optional in the QAPI schema, but the code cosunming the --export
appears to require it.

There is no need to make it optional now just in case: Changing an
option parameter from mandatory to optional is backward-compatible.

> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qapi/block-export.json               |  19 +-
>  block/export/vhost-user-blk-server.h |  23 +-
>  block/export/export.c                |   8 +-
>  block/export/vhost-user-blk-server.c | 461 ++++++++-------------------
>  block/export/meson.build             |   1 +
>  block/meson.build                    |   1 -
>  6 files changed, 156 insertions(+), 357 deletions(-)
>
> diff --git a/qapi/block-export.json b/qapi/block-export.json
> index ace0d66e17..840dcbe833 100644
> --- a/qapi/block-export.json
> +++ b/qapi/block-export.json
> @@ -84,6 +84,19 @@
>    'data': { '*name': 'str', '*description': 'str',
>              '*bitmap': 'str' } }
>  
> +##
> +# @BlockExportOptionsVhostUserBlk:
> +#
> +# A vhost-user-blk block export.
> +#
> +# @unix-socket: Path where the vhost-user UNIX domain socket will be created.
> +# @logical-block-size: Logical block size in bytes.
> +#
> +# Since: 5.2
> +##
> +{ 'struct': 'BlockExportOptionsVhostUserBlk',
> +  'data': { '*unix-socket': 'str', '*logical-block-size': 'size' } }

This is where we make @unix-socket optional.

Default behavior is not documented.

> +
>  ##
>  # @NbdServerAddOptions:
>  #
> @@ -180,11 +193,12 @@
>  # An enumeration of block export types
>  #
>  # @nbd: NBD export
> +# @vhost-user-blk: vhost-user-blk export (since 5.2)
>  #
>  # Since: 4.2
>  ##
>  { 'enum': 'BlockExportType',
> -  'data': [ 'nbd' ] }
> +  'data': [ 'nbd', 'vhost-user-blk' ] }
>  
>  ##
>  # @BlockExportOptions:
> @@ -213,7 +227,8 @@
>              '*writethrough': 'bool' },
>    'discriminator': 'type',
>    'data': {
> -      'nbd': 'BlockExportOptionsNbd'
> +      'nbd': 'BlockExportOptionsNbd',
> +      'vhost-user-blk': 'BlockExportOptionsVhostUserBlk'
>     } }
>  
>  ##
[...]
> diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
> index 44d3c45fa2..9908b3287e 100644
> --- a/block/export/vhost-user-blk-server.c
> +++ b/block/export/vhost-user-blk-server.c
[...]
> -static char *vu_get_unix_socket(Object *obj, Error **errp)
> +static int vu_blk_exp_create(BlockExport *exp, BlockExportOptions *opts,
> +                             Error **errp)
>  {
> -    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
> -    return g_strdup(vus->addr->u.q_unix.path);
> -}
> -
> -static bool vu_get_block_writable(Object *obj, Error **errp)
> -{
> -    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
> -    return vus->writable;
> -}
> -
> -static void vu_set_block_writable(Object *obj, bool value, Error **errp)
> -{
> -    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
> -
> -    if (!vu_prop_modifiable(vus, errp)) {
> -            return;
> -    }
> -
> -    vus->writable = value;
> -}
> -
> -static void vu_get_blk_size(Object *obj, Visitor *v, const char *name,
> -                            void *opaque, Error **errp)
> -{
> -    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
> -    uint32_t value = vus->blk_size;
> -
> -    visit_type_uint32(v, name, &value, errp);
> -}
> -
> -static void vu_set_blk_size(Object *obj, Visitor *v, const char *name,
> -                            void *opaque, Error **errp)
> -{
> -    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
> -
> +    VuBlkExport *vexp = container_of(exp, VuBlkExport, export);
> +    BlockExportOptionsVhostUserBlk *vu_opts = &opts->u.vhost_user_blk;
> +    SocketAddress addr = {
> +        .type = SOCKET_ADDRESS_TYPE_UNIX,
> +        .u.q_unix.path = vu_opts->has_unix_socket ?
> +                         vu_opts->unix_socket :
> +                         NULL,
> +    };
>      Error *local_err = NULL;
> -    uint32_t value;
> +    uint64_t logical_block_size;
>  
> -    if (!vu_prop_modifiable(vus, errp)) {
> -            return;
> +    if (!vu_opts->has_unix_socket) {
> +        error_setg(errp, "Missing unix-socket path to listen on");
> +        return -EINVAL;
>      }

This is where we require @unix-socket.

>  
> -    visit_type_uint32(v, name, &value, &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
> +    vexp->writable = opts->writable;
> +    vexp->blkcfg.wce = 0;
>  
> -    check_block_size(object_get_typename(obj), name, value, &local_err);
> +    if (vu_opts->has_logical_block_size) {
> +        logical_block_size = vu_opts->logical_block_size;
> +    } else {
> +        logical_block_size = BDRV_SECTOR_SIZE;
> +    }
> +    check_block_size(exp->id, "logical-block-size", logical_block_size,
> +                     &local_err);
>      if (local_err) {
> -        goto out;
> +        error_propagate(errp, local_err);
> +        return -EINVAL;
> +    }
> +    vexp->blk_size = logical_block_size;
> +    blk_set_guest_block_size(exp->blk, logical_block_size);
> +    vu_blk_initialize_config(blk_bs(exp->blk), &vexp->blkcfg,
> +                               logical_block_size);
> +
> +    blk_set_allow_aio_context_change(exp->blk, true);
> +    blk_add_aio_context_notifier(exp->blk, blk_aio_attached, blk_aio_detach,
> +                                 vexp);
> +
> +    if (!vhost_user_server_start(&vexp->vu_server, &addr, exp->ctx,
> +                                 VHOST_USER_BLK_MAX_QUEUES, &vu_blk_iface,
> +                                 errp)) {
> +        blk_remove_aio_context_notifier(exp->blk, blk_aio_attached,
> +                                        blk_aio_detach, vexp);
> +        return -EADDRNOTAVAIL;
>      }
>  
> -    vus->blk_size = value;
> -
> -out:
> -    error_propagate(errp, local_err);
> -}
> -
> -static void vhost_user_blk_server_instance_finalize(Object *obj)
> -{
> -    VuBlockDev *vub = VHOST_USER_BLK_SERVER(obj);
> -
> -    vhost_user_blk_server_stop(vub);
> -
> -    /*
> -     * Unlike object_property_add_str, object_class_property_add_str
> -     * doesn't have a release method. Thus manual memory freeing is
> -     * needed.
> -     */
> -    free_socket_addr(vub->addr);
> -    g_free(vub->node_name);
> -}
> -
> -static void vhost_user_blk_server_complete(UserCreatable *obj, Error **errp)
> -{
> -    VuBlockDev *vub = VHOST_USER_BLK_SERVER(obj);
> -
> -    vhost_user_blk_server_start(vub, errp);
> +    return 0;
>  }
[...]


