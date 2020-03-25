Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AC1C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 06:20:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB3920719
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 06:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB3920719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGzOi-0007hS-RI
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 02:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@proxmox.com>) id 1jGzO6-0007Ap-74
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 02:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dietmar@proxmox.com>) id 1jGzO4-0005dJ-QR
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 02:19:38 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:26302)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dietmar@proxmox.com>)
 id 1jGzO4-0005Zu-K0; Wed, 25 Mar 2020 02:19:36 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3F9AD41E13;
 Wed, 25 Mar 2020 07:19:24 +0100 (CET)
Date: Wed, 25 Mar 2020 07:19:22 +0100 (CET)
From: Dietmar Maurer <dietmar@proxmox.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <1242083041.1.1585117162620@webmail.proxmox.com>
In-Reply-To: <20200324194836.21539-1-philmd@redhat.com>
References: <20200324194836.21539-1-philmd@redhat.com>
Subject: Re: [PATCH-for-5.0] qga-posix: Avoid crashing process when failing
 to allocate memory
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.2-Rev22
X-Originating-Client: open-xchange-appsuite
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.186.127.180
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
Reply-To: Dietmar Maurer <dietmar@proxmox.com>
Cc: qemu-trivial@nongnu.org, Sameeh Jubran <sjubran@redhat.com>,
 qemu-stable@nongnu.org, Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>,
 Basil Salman <basil@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

but error_setg() also calls malloc, so this does not help at all?

> On March 24, 2020 8:48 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>=
 wrote:
>=20
> =20
> Similarly to commit 807e2b6fce0 for Windows, kindly return a
> QMP error message instead of crashing the whole process.
>=20
> Cc: qemu-stable@nongnu.org
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1594054
> Reported-by: Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  qga/commands-posix.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 93474ff770..8f127788e6 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -493,7 +493,13 @@ struct GuestFileRead *qmp_guest_file_read(int64_t ha=
ndle, bool has_count,
>          gfh->state =3D RW_STATE_NEW;
>      }
> =20
> -    buf =3D g_malloc0(count+1);
> +    buf =3D g_try_malloc0(count + 1);
> +    if (!buf) {
> +        error_setg(errp,
> +                   "failed to allocate sufficient memory "
> +                   "to complete the requested service");
> +        return NULL;
> +    }
>      read_count =3D fread(buf, 1, count, fh);
>      if (ferror(fh)) {
>          error_setg_errno(errp, errno, "failed to read file");
> --=20
> 2.21.1


