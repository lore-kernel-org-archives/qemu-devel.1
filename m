Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC7EC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:03:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4879205C9
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4879205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56134 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOkZs-0006Uh-FZ
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 11:03:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1hOkYv-00060x-7b
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1hOkYq-0004CR-6u
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:02:21 -0400
Received: from prv-mh.provo.novell.com ([137.65.248.74]:34243)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brogers@suse.com>) id 1hOkYp-00045W-Tp
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:02:16 -0400
Received: from INET-PRV-MTA by prv-mh.provo.novell.com
	with Novell_GroupWise; Thu, 09 May 2019 09:02:11 -0600
Message-Id: <5CD44158020000480009E63D@prv-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.1 
Date: Thu, 09 May 2019 09:03:52 -0600
From: "Bruce Rogers" <brogers@suse.com>
To: <qemu-devel@nongnu.org>,"Bruce Rogers" <BROGERS@suse.com>
References: <20190411175138.12838-1-brogers@suse.com>
In-Reply-To: <20190411175138.12838-1-brogers@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 137.65.248.74
Subject: Re: [Qemu-devel] [PATCH] hw/smbios: handle both file formats
 regardless of machine type
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>>> On 4/11/2019 at 11:51 AM, Bruce Rogers <brogers@suse.com> wrote:
> It's easy enough to handle either per=E2=80=91spec or legacy smbios =
structures
> in the smbios file input without regard to the machine type used, by
> simply applying the basic smbios formatting rules. then depending on
> what is detected. terminal numm bytes are added or removed for machine
> type specific processing.
>=20
> Signed=E2=80=91off=E2=80=91by: Bruce Rogers <brogers@suse.com>
> =E2=80=91=E2=80=91=E2=80=91
>  hw/smbios/smbios.c | 43 +++++++++++++++++++++++++++++++++++++++=E2=80=91=
=E2=80=91=E2=80=91=E2=80=91
>  1 file changed, 39 insertions(+), 4 deletions(=E2=80=91)
>=20
> diff =E2=80=91=E2=80=91git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 47be9071fa..d4b95ebc84 100644
> =E2=80=91=E2=80=91=E2=80=91 a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ =E2=80=91960,6 +960,7 @@ void smbios_entry_add(QemuOpts *opts, Error =
**errp)
>          struct smbios_structure_header *header;
>          int size;
>          struct smbios_table *table; /* legacy mode only */
> +        uint8_t *dbl_nulls, *orig_end;
> =20
>          qemu_opts_validate(opts, qemu_smbios_file_opts, &err);
>          if (err) {
> @@ =E2=80=91974,11 +975,21 @@ void smbios_entry_add(QemuOpts *opts, =
Error **errp)
>          }
> =20
>          /*
> =E2=80=91         * NOTE: standard double '\0' terminator expected, per =
smbios spec.
> =E2=80=91         * (except in legacy mode, where the second '\0' is =
implicit and
> =E2=80=91         *  will be inserted by the BIOS).
> +         * NOTE: standard double '\0' terminator expected, per smbios =
spec,
> +         * unless the data is formatted for legacy mode, which is used =
by
> +         * pc=E2=80=91i440fx=E2=80=912.0 and earlier machine types. =
Legacy mode structures
> +         * without strings have no '\0' terminators, and those with =
strings
> +         * also don't have an additional '\0' terminator at the end of =
the
> +         * final string '\0' terminator. The BIOS will add the '\0'=20
> terminators
> +         * to comply with the smbios spec.
> +         * For greater compatibility, regardless of the machine type =
used,
> +         * either format is accepted.
>           */
> =E2=80=91        smbios_tables =3D g_realloc(smbios_tables, smbios_tables=
_len + size);
> +        smbios_tables =3D g_realloc(smbios_tables, smbios_tables_len + =
size +=20
> 2);
> +        orig_end =3D smbios_tables + smbios_tables_len + size;
> +        /* add extra null bytes to end in case of legacy file data */
> +        *orig_end =3D '\0';
> +        *(orig_end + 1) =3D '\0';
>          header =3D (struct smbios_structure_header *)(smbios_tables +
>                                                      smbios_tables_len);
> =20
> @@ =E2=80=91993,6 +1004,19 @@ void smbios_entry_add(QemuOpts *opts, =
Error **errp)
>                         header=E2=80=91>type);
>              return;
>          }
> +        for (dbl_nulls =3D smbios_tables + smbios_tables_len + =
header=E2=80=91>length;
> +             dbl_nulls + 2 <=3D orig_end; dbl_nulls++) {
> +            if (*dbl_nulls =3D=3D '\0' && *(dbl_nulls + 1) =3D=3D '\0') =
{
> +                break;
> +            }
> +        }
> +        if (dbl_nulls + 2  < orig_end) {
> +            error_setg(errp, "SMBIOS file data malformed");
> +            return;
> +        }
> +        /* increase size by how many extra nulls were actually needed =
*/
> +        size +=3D dbl_nulls + 2 =E2=80=91 orig_end;
> +        smbios_tables =3D g_realloc(smbios_tables, smbios_tables_len + =
size);
>          set_bit(header=E2=80=91>type, have_binfile_bitmap);
> =20
>          if (header=E2=80=91>type =3D=3D 4) {
> @@ =E2=80=911013,6 +1037,17 @@ void smbios_entry_add(QemuOpts *opts, =
Error **errp)
>           *       delete the one we don't need from smbios_set_defaults()=
,
>           *       once we know which machine version has been requested.
>           */
> +        if (dbl_nulls + 2 =3D=3D orig_end) {
> +            /* chop off nulls to get legacy format */
> +            if (header=E2=80=91>length + 2 =3D=3D size) {
> +                size =E2=80=91=3D 2;
> +            } else {
> +                size =E2=80=91=3D 1;
> +        
    }
> +        } else {
> +            /* undo conversion from legacy format to per=E2=80=91spec =
format */
> +            size =E2=80=91=3D dbl_nulls + 2 =E2=80=91 orig_end;
> +        }
>          if (!smbios_entries) {
>              smbios_entries_len =3D sizeof(uint16_t);
>              smbios_entries =3D g_malloc0(smbios_entries_len);
> =E2=80=91=E2=80=91=20
> 2.21.0

ping

- Bruce

