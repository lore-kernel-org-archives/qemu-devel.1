Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813C0C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:10:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404BA206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdbmekZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404BA206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVC4y-0006cp-4T
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 05:10:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iVC1x-0003nS-7j
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:07:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iVC1v-0003f2-66
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:07:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47209
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iVBzy-0001eS-V5
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:07:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573725910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Ul6TZPsS6djSrZKX6TgQfQjBuXugzYlwxH/HHQyWWY=;
 b=MdbmekZupD8nmRgPdJReQUbvalIfizk2Is3vN+JLeMwi3BR3IIbwttgJe8oC2P/7IzpylA
 LDyCBl46P88c7vAkHCvKSAJNLURITvsYdGqUaC3paX2Ysl9AHL8BpESSit4BV+dRWlXLQ4
 2DCiQGDWs/VCgvyCik1+sXOQb9hDPQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-LxpsUJXmNEmq62YNKSxo_Q-1; Thu, 14 Nov 2019 05:05:07 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6721F18B9F7F;
 Thu, 14 Nov 2019 10:05:06 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF8C219757;
 Thu, 14 Nov 2019 10:05:00 +0000 (UTC)
Message-ID: <32602487093b42c51608a813223dde6deceb6661.camel@redhat.com>
Subject: Re: [PATCH v3 3/4] nbd: Don't send oversize strings
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Date: Thu, 14 Nov 2019 12:04:59 +0200
In-Reply-To: <20191114024635.11363-4-eblake@redhat.com>
References: <20191114024635.11363-1-eblake@redhat.com>
 <20191114024635.11363-4-eblake@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: LxpsUJXmNEmq62YNKSxo_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-11-13 at 20:46 -0600, Eric Blake wrote:
> Qemu as server currently won't accept export names larger than 256
> bytes, nor create dirty bitmap names longer than 1023 bytes, so most
> uses of qemu as client or server have no reason to get anywhere near
> the NBD spec maximum of a 4k limit per string.
>=20
> However, we weren't actually enforcing things, ignoring when the
> remote side violates the protocol on input, and also having several
> code paths where we send oversize strings on output (for example,
> qemu-nbd --description could easily send more than 4k).  Tighten
> things up as follows:
>=20
> client:
> - Perform bounds check on export name and dirty bitmap request prior
>   to handing it to server
> - Validate that copied server replies are not too long (ignoring
>   NBD_INFO_* replies that are not copied is not too bad)
> server:
> - Perform bounds check on export name and description prior to
>   advertising it to client
> - Reject client name or metadata query that is too long
> - Adjust things to allow full 4k name limit rather than previous
>   256 byte limit
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  include/block/nbd.h |  8 ++++----
>  block/nbd.c         | 10 ++++++++++
>  blockdev-nbd.c      |  5 +++++
>  nbd/client.c        | 18 +++++++++++++++---
>  nbd/server.c        | 20 +++++++++++++++-----
>  qemu-nbd.c          |  9 +++++++++
>  6 files changed, 58 insertions(+), 12 deletions(-)
>=20
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index c306423dc85c..7f46932d80f1 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -227,11 +227,11 @@ enum {
>  #define NBD_MAX_BUFFER_SIZE (32 * 1024 * 1024)
>=20
>  /*
> - * Maximum size of an export name. The NBD spec requires a minimum of
> - * 256 and recommends that servers support up to 4096; all users use
> - * malloc so we can bump this constant without worry.
> + * Maximum size of a protocol string (export name, meta context name,
> + * etc.).  Use malloc rather than stack allocation for storage of a
> + * string.
>   */
> -#define NBD_MAX_NAME_SIZE 256
> +#define NBD_MAX_STRING_SIZE 4096
>=20
>  /* Two types of reply structures */
>  #define NBD_SIMPLE_REPLY_MAGIC      0x67446698
> diff --git a/block/nbd.c b/block/nbd.c
> index 123976171cf4..5f18f78a9471 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -1832,6 +1832,10 @@ static int nbd_process_options(BlockDriverState *b=
s, QDict *options,
>      }
>=20
>      s->export =3D g_strdup(qemu_opt_get(opts, "export"));
> +    if (s->export && strlen(s->export) > NBD_MAX_STRING_SIZE) {
> +        error_setg(errp, "export name too long to send to server");
> +        goto error;
> +    }
>=20
>      s->tlscredsid =3D g_strdup(qemu_opt_get(opts, "tls-creds"));
>      if (s->tlscredsid) {
> @@ -1849,6 +1853,11 @@ static int nbd_process_options(BlockDriverState *b=
s, QDict *options,
>      }
>=20
>      s->x_dirty_bitmap =3D g_strdup(qemu_opt_get(opts, "x-dirty-bitmap"))=
;
> +    if (s->x_dirty_bitmap && strlen(s->x_dirty_bitmap) > NBD_MAX_STRING_=
SIZE) {
> +        error_setg(errp, "x-dirty-bitmap query too long to send to serve=
r");
> +        goto error;
> +    }
> +
>      s->reconnect_delay =3D qemu_opt_get_number(opts, "reconnect-delay", =
0);
>=20
>      ret =3D 0;
> @@ -1859,6 +1868,7 @@ static int nbd_process_options(BlockDriverState *bs=
, QDict *options,
>          qapi_free_SocketAddress(s->saddr);
>          g_free(s->export);
>          g_free(s->tlscredsid);
> +        g_free(s->x_dirty_bitmap);
>      }
>      qemu_opts_del(opts);
>      return ret;
> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
> index 6a8b206e1d74..8c20baa4a4b9 100644
> --- a/blockdev-nbd.c
> +++ b/blockdev-nbd.c
> @@ -162,6 +162,11 @@ void qmp_nbd_server_add(const char *device, bool has=
_name, const char *name,
>          name =3D device;
>      }
>=20
> +    if (strlen(name) > NBD_MAX_STRING_SIZE) {
> +        error_setg(errp, "export name '%s' too long", name);
> +        return;
> +    }
> +
>      if (nbd_export_find(name)) {
>          error_setg(errp, "NBD server already has export named '%s'", nam=
e);
>          return;
> diff --git a/nbd/client.c b/nbd/client.c
> index f6733962b49b..ba173108baab 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -289,8 +289,8 @@ static int nbd_receive_list(QIOChannel *ioc, char **n=
ame, char **description,
>          return -1;
>      }
>      len -=3D sizeof(namelen);
> -    if (len < namelen) {
> -        error_setg(errp, "incorrect option name length");
> +    if (len < namelen || namelen > NBD_MAX_STRING_SIZE) {
> +        error_setg(errp, "incorrect name length in server's list respons=
e");
>          nbd_send_opt_abort(ioc);
>          return -1;
>      }
> @@ -303,6 +303,12 @@ static int nbd_receive_list(QIOChannel *ioc, char **=
name, char **description,
>      local_name[namelen] =3D '\0';
>      len -=3D namelen;
>      if (len) {
> +        if (len > NBD_MAX_STRING_SIZE) {
> +            error_setg(errp, "incorrect description length in server's "
> +                       "list response");
> +            nbd_send_opt_abort(ioc);
> +            return -1;
> +        }
>          local_desc =3D g_malloc(len + 1);
>          if (nbd_read(ioc, local_desc, len, "export description", errp) <=
 0) {
>              nbd_send_opt_abort(ioc);
> @@ -479,6 +485,10 @@ static int nbd_opt_info_or_go(QIOChannel *ioc, uint3=
2_t opt,
>              break;
>=20
>          default:
> +            /*
> +             * Not worth the bother to check if NBD_INFO_NAME or
> +             * NBD_INFO_DESCRIPTION exceed NBD_MAX_STRING_SIZE.
> +             */
>              trace_nbd_opt_info_unknown(type, nbd_info_lookup(type));
>              if (nbd_drop(ioc, len, errp) < 0) {
>                  error_prepend(errp, "Failed to read info payload: ");
> @@ -645,9 +655,11 @@ static int nbd_send_meta_query(QIOChannel *ioc, uint=
32_t opt,
>      char *p;
>=20
>      data_len =3D sizeof(export_len) + export_len + sizeof(queries);
> +    assert(export_len <=3D NBD_MAX_STRING_SIZE);
>      if (query) {
>          query_len =3D strlen(query);
>          data_len +=3D sizeof(query_len) + query_len;
> +        assert(query_len <=3D NBD_MAX_STRING_SIZE);
>      } else {
>          assert(opt =3D=3D NBD_OPT_LIST_META_CONTEXT);
>      }
> @@ -1009,7 +1021,7 @@ int nbd_receive_negotiate(AioContext *aio_context, =
QIOChannel *ioc,
>      bool zeroes;
>      bool base_allocation =3D info->base_allocation;
>=20
> -    assert(info->name);
> +    assert(info->name && strlen(info->name) <=3D NBD_MAX_STRING_SIZE);
>      trace_nbd_receive_negotiate_name(info->name);
>=20
>      result =3D nbd_start_negotiate(aio_context, ioc, tlscreds, hostname,=
 outioc,
> diff --git a/nbd/server.c b/nbd/server.c
> index c63b76b22735..d28123c562be 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -321,7 +321,7 @@ static int nbd_opt_skip(NBDClient *client, size_t siz=
e, Error **errp)
>  /* nbd_opt_read_name
>   *
>   * Read a string with the format:
> - *   uint32_t len     (<=3D NBD_MAX_NAME_SIZE)
> + *   uint32_t len     (<=3D NBD_MAX_STRING_SIZE)
>   *   len bytes string (not 0-terminated)
>   *
>   * On success, @name will be allocated.
> @@ -344,7 +344,7 @@ static int nbd_opt_read_name(NBDClient *client, char =
**name, uint32_t *length,
>      }
>      len =3D cpu_to_be32(len);
>=20
> -    if (len > NBD_MAX_NAME_SIZE) {
> +    if (len > NBD_MAX_STRING_SIZE) {
>          return nbd_opt_invalid(client, errp,
>                                 "Invalid name length: %" PRIu32, len);
>      }
> @@ -379,6 +379,7 @@ static int nbd_negotiate_send_rep_list(NBDClient *cli=
ent, NBDExport *exp,
>      trace_nbd_negotiate_send_rep_list(name, desc);
>      name_len =3D strlen(name);
>      desc_len =3D strlen(desc);
> +    assert(name_len <=3D NBD_MAX_STRING_SIZE && desc_len <=3D NBD_MAX_ST=
RING_SIZE);
>      len =3D name_len + desc_len + sizeof(len);
>      ret =3D nbd_negotiate_send_rep_len(client, NBD_REP_SERVER, len, errp=
);
>      if (ret < 0) {
> @@ -445,7 +446,7 @@ static int nbd_negotiate_handle_export_name(NBDClient=
 *client, bool no_zeroes,
>          [10 .. 133]   reserved     (0) [unless no_zeroes]
>       */
>      trace_nbd_negotiate_handle_export_name();
> -    if (client->optlen > NBD_MAX_NAME_SIZE) {
> +    if (client->optlen > NBD_MAX_STRING_SIZE) {
>          error_setg(errp, "Bad length received");
>          return -EINVAL;
>      }
> @@ -613,6 +614,7 @@ static int nbd_negotiate_handle_info(NBDClient *clien=
t, Error **errp)
>      if (exp->description) {
>          size_t len =3D strlen(exp->description);
>=20
> +        assert(len <=3D NBD_MAX_STRING_SIZE);
>          rc =3D nbd_negotiate_send_info(client, NBD_INFO_DESCRIPTION,
>                                       len, exp->description, errp);
>          if (rc < 0) {
> @@ -757,6 +759,7 @@ static int nbd_negotiate_send_meta_context(NBDClient =
*client,
>          {.iov_base =3D (void *)context, .iov_len =3D strlen(context)}
>      };
>=20
> +    assert(iov[1].iov_len <=3D NBD_MAX_STRING_SIZE);
>      if (client->opt =3D=3D NBD_OPT_LIST_META_CONTEXT) {
>          context_id =3D 0;
>      }
> @@ -905,7 +908,7 @@ static int nbd_meta_qemu_query(NBDClient *client, NBD=
ExportMetaContexts *meta,
>   * Parse namespace name and call corresponding function to parse body of=
 the
>   * query.
>   *
> - * The only supported namespace now is 'base'.
> + * The only supported namespaces are 'base' and 'qemu'.
>   *
>   * The function aims not wasting time and memory to read long unknown na=
mespace
>   * names.
> @@ -931,6 +934,10 @@ static int nbd_negotiate_meta_query(NBDClient *clien=
t,
>      }
>      len =3D cpu_to_be32(len);
>=20
> +    if (len > NBD_MAX_STRING_SIZE) {
> +        trace_nbd_negotiate_meta_query_skip("length too long");
> +        return nbd_opt_skip(client, len, errp);
> +    }
>      if (len < ns_len) {
>          trace_nbd_negotiate_meta_query_skip("length too short");
>          return nbd_opt_skip(client, len, errp);
> @@ -1492,7 +1499,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uin=
t64_t dev_offset,
>       * access since the export could be available before migration hando=
ver.
>       * ctx was acquired in the caller.
>       */
> -    assert(name);
> +    assert(name && strlen(name) <=3D NBD_MAX_STRING_SIZE);
>      ctx =3D bdrv_get_aio_context(bs);
>      bdrv_invalidate_cache(bs, NULL);
>=20
> @@ -1518,6 +1525,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uin=
t64_t dev_offset,
>      assert(dev_offset <=3D INT64_MAX);
>      exp->dev_offset =3D dev_offset;
>      exp->name =3D g_strdup(name);
> +    assert(!desc || strlen(desc) <=3D NBD_MAX_STRING_SIZE);
>      exp->description =3D g_strdup(desc);
>      exp->nbdflags =3D (NBD_FLAG_HAS_FLAGS | NBD_FLAG_SEND_FLUSH |
>                       NBD_FLAG_SEND_FUA | NBD_FLAG_SEND_CACHE);
> @@ -1564,8 +1572,10 @@ NBDExport *nbd_export_new(BlockDriverState *bs, ui=
nt64_t dev_offset,
>=20
>          bdrv_dirty_bitmap_set_busy(bm, true);
>          exp->export_bitmap =3D bm;
> +        assert(strlen(bitmap) <=3D BDRV_BITMAP_MAX_NAME_SIZE);
>          exp->export_bitmap_context =3D g_strdup_printf("qemu:dirty-bitma=
p:%s",
>                                                       bitmap);
> +        assert(strlen(exp->export_bitmap_context) < NBD_MAX_STRING_SIZE)=
;
>      }
>=20
>      exp->close =3D close;
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index caacf0ed7379..108a51f7eb01 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -833,9 +833,18 @@ int main(int argc, char **argv)
>              break;
>          case 'x':
>              export_name =3D optarg;
> +            if (strlen(export_name) > NBD_MAX_STRING_SIZE) {
> +                error_report("export name '%s' too long", export_name);
> +                exit(EXIT_FAILURE);
> +            }
>              break;
>          case 'D':
>              export_description =3D optarg;
> +            if (strlen(export_description) > NBD_MAX_STRING_SIZE) {
> +                error_report("export description '%s' too long",
> +                             export_description);
> +                exit(EXIT_FAILURE);
> +            }
>              break;
>          case 'v':
>              verbose =3D 1;

Maybe I would split that patch into server side checks,
then client side checks, and then patch that adds bunch
of asserts, which are true after client side checks are added.


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
=09Maxim Levitsky


