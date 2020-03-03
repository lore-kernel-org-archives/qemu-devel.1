Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A376C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 07:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698B8214D8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 07:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNlrF1yE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698B8214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j92Rz-0001Q3-LN
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 02:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j92RJ-0000uK-Ck
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 02:58:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j92RH-00072n-NS
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 02:58:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43146)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j92RH-00072X-JW
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 02:58:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583222282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YSE2OaXNcLVub0jG7VpQpTvxTrxkDHKCyLguh6I8tPc=;
 b=YNlrF1yEDeA/97dB2TxkWWJgqE/y7ymycqP7ZywMR41zokN4EANlv+SQ/+nsgUCq/Y3hLF
 POciH5nyVZTvMmGEtMI4iLCnV7EldJ1PU7Mrhwj3DpjUC3PnfFPOSax6i62aErKD12Plxq
 5rCCRViii0xoe1WsuK/RMIqelkeqaKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-vaOEXsnhP7KqR4DrxUDycg-1; Tue, 03 Mar 2020 02:58:01 -0500
X-MC-Unique: vaOEXsnhP7KqR4DrxUDycg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B68F800D4E;
 Tue,  3 Mar 2020 07:58:00 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA2923A6;
 Tue,  3 Mar 2020 07:57:58 +0000 (UTC)
Date: Tue, 3 Mar 2020 08:57:57 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [EXTERNAL][PATCH] mips/mips_malta: Allow more than 2G RAM
Message-ID: <20200303085757.395c5002@redhat.com>
In-Reply-To: <8ad428b2-834e-7f33-eb96-dd0aa1aad8ed@redhat.com>
References: <20200228032613.1049955-1-jiaxun.yang@flygoat.com>
 <BN6PR2201MB12518300604D482EAE3CA145C6E70@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <8ad428b2-834e-7f33-eb96-dd0aa1aad8ed@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Yunqiang Su <ysu@wavecomp.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Mar 2020 00:59:26 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 3/2/20 10:22 PM, Aleksandar Markovic wrote:
> > Forwarding this to Igor. Can you please give us your opinion, Igor, on =
this proposal? =20
>=20
> I'm not sure it is Igor area.
true,

as far as board consumes all machine->ram and works fine when
user specifies insane -m value there, it would be fine with me.
=20
> What need to be reviewed here is the GT64120 north bridge, which works=20
> very well with the default config, but is fragile when modifying it.
>=20
> I'd be more confident with an acceptance test running memtester.
>=20
> > ________________________________________
> > From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Sent: Friday, February 28, 2020 4:26 AM
> > To: qemu-devel@nongnu.org
> > Cc: philmd@redhat.com; Aleksandar Markovic; Jiaxun Yang; Yunqiang Su
> > Subject: [EXTERNAL][PATCH] mips/mips_malta: Allow more than 2G RAM
> >=20
> > When malta is coupled with MIPS64 cpu which have 64bit
> > address space, it is possible to have more than 2G RAM.
> >=20
> > So we removed ram_size check and overwrite memory
> > layout for these targets.
> >=20
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Suggested-by: Yunqiang Su <ysu@wavecomp.com>
> > ---
> >   hw/mips/mips_malta.c | 24 ++++++++++++++++++------
> >   1 file changed, 18 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> > index 6e7ba9235d..de89cdcfc1 100644
> > --- a/hw/mips/mips_malta.c
> > +++ b/hw/mips/mips_malta.c
> > @@ -98,7 +98,8 @@ typedef struct {
> >   } MaltaState;
> >=20
> >   static struct _loaderparams {
> > -    int ram_size, ram_low_size;
> > +    unsigned int ram_low_size;
> > +    ram_addr_t ram_size;
> >       const char *kernel_filename;
> >       const char *kernel_cmdline;
> >       const char *initrd_filename;
> > @@ -1023,6 +1024,7 @@ static int64_t load_kernel(void)
> >   {
> >       int64_t kernel_entry, kernel_high, initrd_size;
> >       long kernel_size;
> > +    char mem_cmdline[128];
> >       ram_addr_t initrd_offset;
> >       int big_endian;
> >       uint32_t *prom_buf;
> > @@ -1099,20 +1101,28 @@ static int64_t load_kernel(void)
> >       prom_buf =3D g_malloc(prom_size);
> >=20
> >       prom_set(prom_buf, prom_index++, "%s", loaderparams.kernel_filena=
me);
> > +
> > +    /*
> > +     * Always use cmdline to overwrite mem layout
> > +     * as kernel may reject large emesize.
> > +     */
> > +    sprintf(&mem_cmdline[0],
> > +        "mem=3D0x10000000@0x00000000 mem=3D0x%" PRIx64 "@0x90000000",
> > +        loaderparams.ram_size - 0x10000000);
> >       if (initrd_size > 0) {
> >           prom_set(prom_buf, prom_index++,
> > -                 "rd_start=3D0x%" PRIx64 " rd_size=3D%" PRId64 " %s",
> > -                 xlate_to_kseg0(NULL, initrd_offset),
> > +                 "%s rd_start=3D0x%" PRIx64 " rd_size=3D%" PRId64 " %s=
",
> > +                 &mem_cmdline[0], xlate_to_kseg0(NULL, initrd_offset),
> >                    initrd_size, loaderparams.kernel_cmdline);
> >       } else {
> > -        prom_set(prom_buf, prom_index++, "%s", loaderparams.kernel_cmd=
line);
> > +        prom_set(prom_buf, prom_index++, "%s %s",&mem_cmdline[0] ,load=
erparams.kernel_cmdline);
> >       }
> >=20
> >       prom_set(prom_buf, prom_index++, "memsize");
> >       prom_set(prom_buf, prom_index++, "%u", loaderparams.ram_low_size)=
;
> >=20
> >       prom_set(prom_buf, prom_index++, "ememsize");
> > -    prom_set(prom_buf, prom_index++, "%u", loaderparams.ram_size);
> > +    prom_set(prom_buf, prom_index++, "%lu", loaderparams.ram_size);
> >=20
> >       prom_set(prom_buf, prom_index++, "modetty0");
> >       prom_set(prom_buf, prom_index++, "38400n8r");
> > @@ -1253,12 +1263,14 @@ void mips_malta_init(MachineState *machine)
> >       /* create CPU */
> >       mips_create_cpu(machine, s, &cbus_irq, &i8259_irq);
> >=20
> > -    /* allocate RAM */
> > +#ifdef TARGET_MIPS32
> > +    /* MIPS32 won't accept more than 2GiB RAM due to limited address s=
pace */
> >       if (ram_size > 2 * GiB) {
> >           error_report("Too much memory for this machine: %" PRId64 "MB=
,"
> >                        " maximum 2048MB", ram_size / MiB);
> >           exit(1);
> >       }
> > +#endif
> >=20
> >       /* register RAM at high address where it is undisturbed by IO */
> >       memory_region_add_subregion(system_memory, 0x80000000, machine->r=
am);
> > --
> > 2.25.1
> >=20
> >=20
> >=20
> >  =20
>=20


