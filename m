Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F716C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFBB12076C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hp.com header.i=@hp.com header.b="SZ9gPsCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBB12076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGkuI-0001UT-04
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 11:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erich.mcmillan@hp.com>)
 id 1kGktI-0000Iu-Ia
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:23:08 -0400
Received: from us-smtp-delivery-162.mimecast.com ([63.128.21.162]:59109)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <erich.mcmillan@hp.com>)
 id 1kGktE-0006GA-I8
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com;
 s=mimecast20180716; t=1599837782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xkcytF7taKxHP43CxRMILDytojaS1M3NcI+Mi/s4NXM=;
 b=SZ9gPsCpLB1GA2VPaAf3oAhN6IUaKxMOAyDhKMiBPfXhPvgkneN7RZ4DzchicGZNkQafFO
 XkGW+uGgeNoqLUwjuKU0Z5uWDTHbAiHs+lyCMz4Bnrn28hotDEM952fU0An7Mw6lyWU5s/
 TclTBD6Reho+qSqJjCYOsZrM3ysjius=
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-7bFFUMZnMkaQGX5RqpcgBw-1; Fri, 11 Sep 2020 11:23:00 -0400
X-MC-Unique: 7bFFUMZnMkaQGX5RqpcgBw-1
Received: from CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7507::9) by CS1PR8401MB1224.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7507::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 11 Sep
 2020 15:22:57 +0000
Received: from CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::40df:1118:3bef:736c]) by CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::40df:1118:3bef:736c%12]) with mapi id 15.20.3370.017; Fri, 11 Sep
 2020 15:22:57 +0000
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Laszlo Ersek
 <lersek@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, Markus Armbruster
 <armbru@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@redhat.com>
Subject: Re: PATCH: Increase System Firmware Max Size
Thread-Topic: PATCH: Increase System Firmware Max Size
Thread-Index: AQHWh9wbvH3PA15ju0WtYVYwRPIQ7qljEg0AgAAK3ACAAGnfAIAAA6AAgAAAePk=
Date: Fri, 11 Sep 2020 15:22:57 +0000
Message-ID: <CS1PR8401MB03273F105DE3FA773E2DB2F5F3240@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
References: <CS1PR8401MB0327EF9D532330BA44257AFCF3240@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
 <20c5210f-8199-a9e7-9297-0bea06c4d9ae@redhat.com>
 <20200911083408.GA3310@work-vm>
 <ae2d820e-78c6-da92-2fa6-73c1a7d10333@redhat.com>,
 <20200911150602.GH3310@work-vm>
In-Reply-To: <20200911150602.GH3310@work-vm>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.56.53.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc198ccb-e1a8-48fb-9da2-08d856668fd6
x-ms-traffictypediagnostic: CS1PR8401MB1224:
x-microsoft-antispam-prvs: <CS1PR8401MB122412F5571A222FD4B8E488F3240@CS1PR8401MB1224.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ERJ1l67ErQ/3wITsd+ELPzkl8mIZCSr26dEwpXXxkSz5+T6ZMj/SC7mk751lwuMsfRH6B763f9faouTKtC+uvqyuKC2og9ohdkHD7fhHqtI3YTBa4QOGPiE9/svC+I/TWG/X3eFfwGvGDYTMZ4HQA10t/myoxNO5m1NuztSCtLpB/8nrE9N08VZj/HH71sFwHtIn3dZURdd5QZHnbXgjj3yIkJIq7QLdzYeOoxoCEVaDTWbiJYgKAyhjB6C+RzKNOUnRt+cSVJzadOxnRjV4UkYgEm8A47erG95NDWJjpxYsm0oxwnIaY3n0GeO3UkU3Jbm+w0oz7dk5oUgpnYHhvHzqtK+RbbtjNqLFqZUJisKO9Wffl+N9elR/3goK5Jzd1qSbpiFqflFNCqRuxVCksA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(346002)(396003)(376002)(136003)(366004)(39860400002)(55016002)(66946007)(110136005)(9686003)(30864003)(8936002)(86362001)(71200400001)(64756008)(478600001)(66446008)(52536014)(66476007)(66556008)(54906003)(33656002)(4326008)(8676002)(26005)(6506007)(166002)(2906002)(76116006)(19627405001)(5660300002)(91956017)(186003)(316002)(53546011)(7696005)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: nLMmr0LyYkK5NM4QKERR/VaRhNNF2xuF95rghZ5wj7NCg24N5FCeG5HjTQmtho2CxA223YZD51mA22ClgArDdZQ6+vBHlukp0Jo+Z7E1y4wNsvhL1Iikb7fVuEfrO5A74cFKYIHZPPVr5l7Y7DKSO6AhwYtdPy1POt5iWDaVzxO2hNXIRAJfGf0dAPJ7JLm6YnC2YEoeByEyJ0JqAARPOPOhklUnhYZE+kCAnrI26Cc/0f+T2yAcjZmoFVyV7ogQhxQLaW//HCEO55GF9XuxZTOhCIL4FPQLWnAYgiW9SEPT5e/BrUoKId+xPXQOww1H44qVBMenSPU720B3TzOYJVChiRurzy2yhGM9B3IQHQIAcbHliCl1cE2XYwBvwX7hcSTpq593TkQR2eYC+m0O+OX+BAizilOVAf8j2NiSB0OShB+31KBaltykOSqsyVznreEdRKp9oZ97CJtaeDnKnAMNYbtyaUDpyyMC0tXEdJ+PsWy5eo7hHrQzCfoMrg2aEuYn0O3lopatDKzcgzoGf/nrp0tTYfaYnmvgc4NtQWh2toFl1VeuSqP+9P2aO1IR6ZHBWuX4Bu35NKgzs2R810e01Lr0XIqEKvcxAwqi6IA9XDlTRER6Vkbbq6iwwOmheId/Ad18eilHfRpKYrLWiw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bc198ccb-e1a8-48fb-9da2-08d856668fd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 15:22:57.1485 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ca7981a2-785a-463d-b82a-3db87dfc3ce6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kn2GhQz1UML3bEp4EmnRWv4WIrqhtNYaGzKj1ikLGXgBcpQZ5QpeXmgAwI/2H58cYG15B60ejBSEcuuppY1JLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB1224
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA62A171 smtp.mailfrom=erich.mcmillan@hp.com
X-Mimecast-Spam-Score: 0.004
X-Mimecast-Originator: hp.com
Content-Type: multipart/alternative;
 boundary="_000_CS1PR8401MB03273F105DE3FA773E2DB2F5F3240CS1PR8401MB0327_"
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.162; envelope-from=erich.mcmillan@hp.com;
 helo=us-smtp-delivery-162.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 11:23:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: "McMillan, Erich" <erich.mcmillan@hp.com>
From: "McMillan, Erich" via <qemu-devel@nongnu.org>

--_000_CS1PR8401MB03273F105DE3FA773E2DB2F5F3240CS1PR8401MB0327_
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

Hi Dave, and Laszlo,

I'm not exactly following your email '>' formatting on this discussion so a=
pologies if I've messed it up.


________________________________
From: Dr. David Alan Gilbert <dgilbert@redhat.com>
Sent: Friday, September 11, 2020 10:06 AM
To: Laszlo Ersek <lersek@redhat.com>
Cc: McMillan, Erich <erich.mcmillan@hp.com>; qemu-devel@nongnu.org <qemu-de=
vel@nongnu.org>; mst@redhat.com <mst@redhat.com>; marcel.apfelbaum@gmail.co=
m <marcel.apfelbaum@gmail.com>; qemu-trivial@nongnu.org <qemu-trivial@nongn=
u.org>; Markus Armbruster <armbru@redhat.com>; Philippe Mathieu-Daud=E9 <ph=
ilmd@redhat.com>
Subject: Re: PATCH: Increase System Firmware Max Size

>* Laszlo Ersek (lersek@redhat.com) wrote:
> On 09/11/20 10:34, Dr. David Alan Gilbert wrote:
> > * Laszlo Ersek (lersek@redhat.com) wrote:
> >> +Markus, Dave, Phil
> >>
> >> On 09/11/20 03:45, McMillan, Erich wrote:
> >>> Hi all,
> >>>
> >>> (this is my first Qemu patch submission, please let me know if my for=
matting/content needs to be fixed).
> >>> We have a need for increased firmware size, currently we are building=
 Qemu with the following change to test our Uefi Firmware and it works well=
 for us. Hope that this change can be made to open source. Thank you.
> >>> -------
> >>> Increase allowed system firmware size to 16M per comment suggesting u=
p to 18M is permissible.
> >>>
> >>> Signed-off-by: Erich McMillan <erich.mcmillan@hp.com>
> >>>
> >>> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> >>> index b8d8ef59eb17c6ace8194fc69c3d27809becfbc0..f6f7cd744d0690cee0355=
fbd19ffdcdb71ea75ca 100644
> >>> --- a/hw/i386/pc_sysfw.c
> >>> +++ b/hw/i386/pc_sysfw.c
> >>> @@ -46,7 +46,7 @@
> >>> * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to=
 8MB in
> >>> * size.
> >>> */
> >>> -#define FLASH_SIZE_LIMIT (8 * MiB)
> >>> +#define FLASH_SIZE_LIMIT (16 * MiB)
> >>>
> >>> #define FLASH_SECTOR_SIZE 4096
> >>> -------
> >>>
> >>>
> >>
> >> (1) This is not a trivial change, so qemu-trivial: please ignore.
> >>
> >> (2) The comment has not been updated.
> >>
> >> (3) I'm almost certain that *if* we want to change this, it needs to b=
e
> >> turned into a machine type (or some device model) property, for
> >> migration compatibility.
> >
> > I'm missing what this constant exists for - why is the
> > check there at all Is there something else that lives below this
> > address that we have to protect?
>
> Yes, some MMIOs that I'm at least aware of are IO_APIC_DEFAULT_ADDRESS
> (0xfec00000), TPM_PPI_ADDR_BASE (0xFED45000), APIC_DEFAULT_ADDRESS
> (0xfee00000).
>
> They are not directly adjacent with pflash; nor should they be.

Hmm those need explicitly checks adding somewhere against
FLASH_SIZE_LIMIT!

> On one hand, the current FLASH_SIZE_LIMIT is meant to be sufficient for
> a long time ("should be enough for anyone").
>
> On the other hand, if we have a really strong reason to increase the
> size limit, the current value is supposed to give us a safety margin, so
> that we can satisfy the immediate need at that point *first*, and start
> looking into (likely more intrusive) physical address map changes, to
> restore the safety margin.
>
> > My reading of the code is that increasing that constant doesn't change
> > the guests view at all, as long as the guest was given the same flash
> > files - so if the guests view doesn't change, then why would we tie
> > it to the machine type?
>
> If you increase the size limit (without tieing it to a machine type),
> then, with an upgraded QEMU and the same (old) machine type, you can
> start a guest with a larger-than-earlier (cumulative) flash size. Then,
> when you try to migrate this to an old QEMU (but same machine type),
> it's a bad surprise. I understand that backwards migration is not
> universally supported (or expected), but I don't want this problem to
> land on my desk *ever*.

I support backwards migration; but that migration wouldn't work anyway -
wouldn't that fail nicely with a mismatched RAMBlock size?

> Furthermore, un-enumerable / platform-MMIO devices tend to pop up time
> after time. TPM_PPI_ADDR_BASE (0xFED45000) is a somewhat recent
> addition, for example. It's not like we're never going to need more
> address space up there.
>
> >
> >> (4) I feel we need much more justification for this change than just
> >> "our firmware is larger than upstream OVMF".
> >>
> >> In the upstream 4MB unified OVMF build, there's *plenty* of free room.
> >> Of course that's not to say that we're willing to *squander* that spac=
e
> >> -- whenever we include anything new in the upstream OVMF platform(s),
> >> there must be a very good reason for it --, just that, given the
> >> upstream OVMF status, the proposed pflash increase in QEMU is staggeri=
ng.
> >>
> >> Considering upstream OVMF and QEMU, it should take *years* to even get
> >> close to filling the 4MB unified flash image of OVMF (hint: link-time
> >> optimization, LZMA compression), let alone to exhaust the twice as lar=
ge
> >> (8MB) QEMU allowance.
> >>
> >> Unless you are committed to open source your guest firmware too (maybe
> >> as part of upstream edk2, maybe elsewhere), I seriously doubt we shoul=
d
> >> accommodate this use case in *upstream* QEMU. It complicates things
> >> (minimally with regard to migration), and currently I don't see the
> >> benefit to the upstream community.
> >>
> >> Clearly, for building your firmware image, you must have minimally
> >> modified the DSC and FDF files in OVMF too, or created an entirely
> >> separate firmware platform -- DSC and FDF both.
> >>
> >> If you are using your downstream OVMF build as a testbed for your
> >> proprietary physical platform firmware, that's generally a use case th=
at
> >> we're mildly interested in not breaking in upstream OvmfPkg. But in
> >> order to make me care for real (as an OvmfPkg co-maintainer), you'd ne=
ed
> >> to upstream your OVMF platform to edk2 (we already have Xen and --
> >> recently added -- bhyve firmware platforms under OvmfPkg, not just
> >> QEMU). You'd also have to offer long-term reviewership and testing for
> >> that platform in edk2 (like the Xen and bhyve stake-holders do). Then =
we
> >> could consider additional complexity in QEMU for booting that firmware
> >> platform.
> >
> > Our UEFI firmware is pretty sparse;
>
> Yes, in part because I strive to keep it that way.

But that's your choice, on our firmware implementation; that's not a
requirement of QEMU or q35.

> I fight to keep out
> all cruft that I can (at least by conditionalizing it) so that there is
> room for the stuff that I cannot keep out. (And I always strive to set
> expectations that flipping all possible build knobs in OVMF to "on" may
> very well cause an "out of space" error.)
>
> - I've made sure that PVSCSI_ENABLE and MPT_SCSI_ENABLE be stand-alone
> config knobs. The use case behind them is valid, the drivers are open
> source, but the use case is still niche, so they must be easy to keep out=
.
>
> - I've made sure LSI_SCSI_ENABLE is a stand-alone config knob too (and
> it even defaults to FALSE). The QEMU device that the driver drives is
> obsolete / deprecated.
>
> - If VMBus drivers are ever going to be contributed, they'll need a
> config knob.
>
> - Current Xen code in OVMF is supposed to be separated completely to the
> new, dedicated XenPVH platform
> <https://bugzilla.tianocore.org/show_bug.cgi?id=3D2122<https://bugzilla.t=
ianocore.org/show_bug.cgi?id=3D2122>>.
>
> - Bhyve support is a separate platform build.
>
> - Capsule updates are not supported by OVMF, and if they will ever be,
> they're going to have to be a separate firmware platform. Datacenter
> virtualization has no use for capsule updates.
>
> - The next big thing I expect to have to keep out of OVMF is Redfish
> <https://en.wikipedia.org/wiki/Redfish_(specification)<https://en.wikiped=
ia.org/wiki/Redfish_(specification)>>. Libvirt,
> OpenStack, Cockpit, Kubernetes already handle that area *underneath* the
> guest, I believe. (It's OK to use OVMF for developing / testing Redfish;
> it's not OK to expect that the current OVMF firmware platform contain
> everything that it contains now *plus* Redfish.)
>
> Sparse is *good*.
>
> > it doesn't have any pretty graphics
> > or snazzy stuff,
>
> Which is arguably completely superfluous on every possible platform one
> can imagine. On the other hand, if you want a real serial port on
> workstation class hardware, you may have to order a separate part (if
> you are lucky and you *can* order one). Serial-over-LAN is a complete
> non-replacement.
>
> The reason (should I say: excuse) for the firmware to exist is to (a)
> boot operating systems, (b) abstract away some ugly platform-specific
> hardware for OS runtime (by providing ACPI and SMBIOS descriptions, and
> a *small* set of runtime services). We can maybe add (c) "root of trust".
>
> In practice, physical firmware is becoming the hw vendor's OS before
> (and under) your OS, one you cannot replace, and one whose updates can
> brick your hardware. Permitting the same feature creep on virtual
> platforms is wrong.

On the firmware you develop that choice is fine; but there's no reason
to force that restriction onto others.

I agree that fw has become the vendor OS, but at this point there's no goin=
g back.
Utilizing a virtual platform allows us to greatly increase the security of =
our code,
could we make this change a Qemu experimental flag, so that fw vendors coul=
d
use it at their own risk?

> > or have to survive configuring lots of hardware; also
> > I'm aware of other companies who are looking at putting big blobs
> > of stuff in firmware for open uses;
>
> Key term being "open uses". Let us see them.

Well yes, I think we know who we're speaking about here and we're
working on it.

> > so I don't see a problem with
> > changing this limit from the QEMU side of things.
>
> I do. Software and data always expand to consume all available space,
> and it's going to cause a conflict between UEFI features and platform
> MMIO sooner or later. Then I'll get the privilege of shuffling around
> the crap in OVMF (all of which is "indispensable" or course).
>
> If we ever go down this route, it needs to benefit open source directly
> and significantly.

Being able to use QEMU to let vendors debug their platform firmware is a
perfectly reasonable use of QEMU; maybe not of your OVMF build - we
need to keep the restrictions on the two separate.

I would hope that continued use of QEMU would encourage us vendors to contr=
ibute
more toward improving the open source project. As Dave pointed out, in no w=
ay
would anyone be forced (or able) to use vendor fw binaries unless we starte=
d to
release them as such, which would not be in our best interests, since we li=
ke to sell hardware.

Dave

> Laszlo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

--_000_CS1PR8401MB03273F105DE3FA773E2DB2F5F3240CS1PR8401MB0327_
Content-Type: text/html; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Hi Dave, and Laszlo,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
I'm not exactly following your email '&gt;' formatting on this discussion s=
o apologies if I've messed it up.</div>
<div id=3D"appendonsend"><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size: 11pt;" data=
-ogsc=3D"" face=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Dr. =
David Alan Gilbert &lt;dgilbert@redhat.com&gt;<br>
<b>Sent:</b> Friday, September 11, 2020 10:06 AM<br>
<b>To:</b> Laszlo Ersek &lt;lersek@redhat.com&gt;<br>
<b>Cc:</b> McMillan, Erich &lt;erich.mcmillan@hp.com&gt;; qemu-devel@nongnu=
.org &lt;qemu-devel@nongnu.org&gt;; mst@redhat.com &lt;mst@redhat.com&gt;; =
marcel.apfelbaum@gmail.com &lt;marcel.apfelbaum@gmail.com&gt;; qemu-trivial=
@nongnu.org &lt;qemu-trivial@nongnu.org&gt;; Markus Armbruster
 &lt;armbru@redhat.com&gt;; Philippe Mathieu-Daud=E9 &lt;philmd@redhat.com&=
gt;<br>
<b>Subject:</b> Re: PATCH: Increase System Firmware Max Size</font>
<div>&nbsp;</div>
</div>
<div>&gt;* Laszlo Ersek (lersek@redhat.com) wrote:<br>
&gt; On 09/11/20 10:34, Dr. David Alan Gilbert wrote:<br>
&gt; &gt; * Laszlo Ersek (lersek@redhat.com) wrote:<br>
&gt; &gt;&gt; +Markus, Dave, Phil<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 09/11/20 03:45, McMillan, Erich wrote:<br>
&gt; &gt;&gt;&gt; Hi all,<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; (this is my first Qemu patch submission, please let me kn=
ow if my formatting/content needs to be fixed).<br>
&gt; &gt;&gt;&gt; We have a need for increased firmware size, currently we =
are building Qemu with the following change to test our Uefi Firmware and i=
t works well for us. Hope that this change can be made to open source. Than=
k you.<br>
&gt; &gt;&gt;&gt; -------<br>
&gt; &gt;&gt;&gt; Increase allowed system firmware size to 16M per comment =
suggesting up to 18M is permissible.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Signed-off-by: Erich McMillan &lt;erich.mcmillan@hp.com&g=
t;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c<br>
&gt; &gt;&gt;&gt; index b8d8ef59eb17c6ace8194fc69c3d27809becfbc0..f6f7cd744=
d0690cee0355fbd19ffdcdb71ea75ca 100644<br>
&gt; &gt;&gt;&gt; --- a/hw/i386/pc_sysfw.c<br>
&gt; &gt;&gt;&gt; +++ b/hw/i386/pc_sysfw.c<br>
&gt; &gt;&gt;&gt; @@ -46,7 +46,7 @@<br>
&gt; &gt;&gt;&gt; * only 18MB-4KB below 4G. For now, restrict the cumulativ=
e mapping to 8MB in<br>
&gt; &gt;&gt;&gt; * size.<br>
&gt; &gt;&gt;&gt; */<br>
&gt; &gt;&gt;&gt; -#define FLASH_SIZE_LIMIT (8 * MiB)<br>
&gt; &gt;&gt;&gt; +#define FLASH_SIZE_LIMIT (16 * MiB)<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; #define FLASH_SECTOR_SIZE 4096<br>
&gt; &gt;&gt;&gt; -------<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; (1) This is not a trivial change, so qemu-trivial: please ign=
ore.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; (2) The comment has not been updated.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; (3) I'm almost certain that *if* we want to change this, it n=
eeds to be<br>
&gt; &gt;&gt; turned into a machine type (or some device model) property, f=
or<br>
&gt; &gt;&gt; migration compatibility.<br>
&gt; &gt; <br>
&gt; &gt; I'm missing what this constant exists for - why is the<br>
&gt; &gt; check there at all Is there something else that lives below this<=
br>
&gt; &gt; address that we have to protect?<br>
&gt; <br>
&gt; Yes, some MMIOs that I'm at least aware of are IO_APIC_DEFAULT_ADDRESS=
<br>
&gt; (0xfec00000), TPM_PPI_ADDR_BASE (0xFED45000), APIC_DEFAULT_ADDRESS<br>
&gt; (0xfee00000).<br>
&gt; <br>
&gt; They are not directly adjacent with pflash; nor should they be.<br>
<br>
Hmm those need explicitly checks adding somewhere against<br>
FLASH_SIZE_LIMIT!<br>
<br>
&gt; On one hand, the current FLASH_SIZE_LIMIT is meant to be sufficient fo=
r<br>
&gt; a long time (&quot;should be enough for anyone&quot;).<br>
&gt; <br>
&gt; On the other hand, if we have a really strong reason to increase the<b=
r>
&gt; size limit, the current value is supposed to give us a safety margin, =
so<br>
&gt; that we can satisfy the immediate need at that point *first*, and star=
t<br>
&gt; looking into (likely more intrusive) physical address map changes, to<=
br>
&gt; restore the safety margin.<br>
&gt; <br>
&gt; &gt; My reading of the code is that increasing that constant doesn't c=
hange<br>
&gt; &gt; the guests view at all, as long as the guest was given the same f=
lash<br>
&gt; &gt; files - so if the guests view doesn't change, then why would we t=
ie<br>
&gt; &gt; it to the machine type?<br>
&gt; <br>
&gt; If you increase the size limit (without tieing it to a machine type),<=
br>
&gt; then, with an upgraded QEMU and the same (old) machine type, you can<b=
r>
&gt; start a guest with a larger-than-earlier (cumulative) flash size. Then=
,<br>
&gt; when you try to migrate this to an old QEMU (but same machine type),<b=
r>
&gt; it's a bad surprise. I understand that backwards migration is not<br>
&gt; universally supported (or expected), but I don't want this problem to<=
br>
&gt; land on my desk *ever*.<br>
<br>
I support backwards migration; but that migration wouldn't work anyway -<br=
>
wouldn't that fail nicely with a mismatched RAMBlock size?<br>
<br>
&gt; Furthermore, un-enumerable / platform-MMIO devices tend to pop up time=
<br>
&gt; after time. TPM_PPI_ADDR_BASE (0xFED45000) is a somewhat recent<br>
&gt; addition, for example. It's not like we're never going to need more<br=
>
&gt; address space up there.<br>
&gt; <br>
&gt; &gt; <br>
&gt; &gt;&gt; (4) I feel we need much more justification for this change th=
an just<br>
&gt; &gt;&gt; &quot;our firmware is larger than upstream OVMF&quot;.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; In the upstream 4MB unified OVMF build, there's *plenty* of f=
ree room.<br>
&gt; &gt;&gt; Of course that's not to say that we're willing to *squander* =
that space<br>
&gt; &gt;&gt; -- whenever we include anything new in the upstream OVMF plat=
form(s),<br>
&gt; &gt;&gt; there must be a very good reason for it --, just that, given =
the<br>
&gt; &gt;&gt; upstream OVMF status, the proposed pflash increase in QEMU is=
 staggering.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Considering upstream OVMF and QEMU, it should take *years* to=
 even get<br>
&gt; &gt;&gt; close to filling the 4MB unified flash image of OVMF (hint: l=
ink-time<br>
&gt; &gt;&gt; optimization, LZMA compression), let alone to exhaust the twi=
ce as large<br>
&gt; &gt;&gt; (8MB) QEMU allowance.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Unless you are committed to open source your guest firmware t=
oo (maybe<br>
&gt; &gt;&gt; as part of upstream edk2, maybe elsewhere), I seriously doubt=
 we should<br>
&gt; &gt;&gt; accommodate this use case in *upstream* QEMU. It complicates =
things<br>
&gt; &gt;&gt; (minimally with regard to migration), and currently I don't s=
ee the<br>
&gt; &gt;&gt; benefit to the upstream community.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Clearly, for building your firmware image, you must have mini=
mally<br>
&gt; &gt;&gt; modified the DSC and FDF files in OVMF too, or created an ent=
irely<br>
&gt; &gt;&gt; separate firmware platform -- DSC and FDF both.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; If you are using your downstream OVMF build as a testbed for =
your<br>
&gt; &gt;&gt; proprietary physical platform firmware, that's generally a us=
e case that<br>
&gt; &gt;&gt; we're mildly interested in not breaking in upstream OvmfPkg. =
But in<br>
&gt; &gt;&gt; order to make me care for real (as an OvmfPkg co-maintainer),=
 you'd need<br>
&gt; &gt;&gt; to upstream your OVMF platform to edk2 (we already have Xen a=
nd --<br>
&gt; &gt;&gt; recently added -- bhyve firmware platforms under OvmfPkg, not=
 just<br>
&gt; &gt;&gt; QEMU). You'd also have to offer long-term reviewership and te=
sting for<br>
&gt; &gt;&gt; that platform in edk2 (like the Xen and bhyve stake-holders d=
o). Then we<br>
&gt; &gt;&gt; could consider additional complexity in QEMU for booting that=
 firmware<br>
&gt; &gt;&gt; platform.<br>
&gt; &gt; <br>
&gt; &gt; Our UEFI firmware is pretty sparse;<br>
&gt; <br>
&gt; Yes, in part because I strive to keep it that way.<br>
<br>
But that's your choice, on our firmware implementation; that's not a<br>
requirement of QEMU or q35.<br>
<br>
&gt; I fight to keep out<br>
&gt; all cruft that I can (at least by conditionalizing it) so that there i=
s<br>
&gt; room for the stuff that I cannot keep out. (And I always strive to set=
<br>
&gt; expectations that flipping all possible build knobs in OVMF to &quot;o=
n&quot; may<br>
&gt; very well cause an &quot;out of space&quot; error.)<br>
&gt; <br>
&gt; - I've made sure that PVSCSI_ENABLE and MPT_SCSI_ENABLE be stand-alone=
<br>
&gt; config knobs. The use case behind them is valid, the drivers are open<=
br>
&gt; source, but the use case is still niche, so they must be easy to keep =
out.<br>
&gt; <br>
&gt; - I've made sure LSI_SCSI_ENABLE is a stand-alone config knob too (and=
<br>
&gt; it even defaults to FALSE). The QEMU device that the driver drives is<=
br>
&gt; obsolete / deprecated.<br>
&gt; <br>
&gt; - If VMBus drivers are ever going to be contributed, they'll need a<br=
>
&gt; config knob.<br>
&gt; <br>
&gt; - Current Xen code in OVMF is supposed to be separated completely to t=
he<br>
&gt; new, dedicated XenPVH platform<br>
&gt; &lt;<a href=3D"https://bugzilla.tianocore.org/show_bug.cgi?id=3D2122">=
https://bugzilla.tianocore.org/show_bug.cgi?id=3D2122</a>&gt;.<br>
&gt; <br>
&gt; - Bhyve support is a separate platform build.<br>
&gt; <br>
&gt; - Capsule updates are not supported by OVMF, and if they will ever be,=
<br>
&gt; they're going to have to be a separate firmware platform. Datacenter<b=
r>
&gt; virtualization has no use for capsule updates.<br>
&gt; <br>
&gt; - The next big thing I expect to have to keep out of OVMF is Redfish<b=
r>
&gt; &lt;<a href=3D"https://en.wikipedia.org/wiki/Redfish_(specification)">=
https://en.wikipedia.org/wiki/Redfish_(specification)</a>&gt;. Libvirt,<br>
&gt; OpenStack, Cockpit, Kubernetes already handle that area *underneath* t=
he<br>
&gt; guest, I believe. (It's OK to use OVMF for developing / testing Redfis=
h;<br>
&gt; it's not OK to expect that the current OVMF firmware platform contain<=
br>
&gt; everything that it contains now *plus* Redfish.)<br>
&gt; <br>
&gt; Sparse is *good*.<br>
&gt; <br>
&gt; &gt; it doesn't have any pretty graphics<br>
&gt; &gt; or snazzy stuff,<br>
&gt; <br>
&gt; Which is arguably completely superfluous on every possible platform on=
e<br>
&gt; can imagine. On the other hand, if you want a real serial port on<br>
&gt; workstation class hardware, you may have to order a separate part (if<=
br>
&gt; you are lucky and you *can* order one). Serial-over-LAN is a complete<=
br>
&gt; non-replacement.<br>
&gt; <br>
&gt; The reason (should I say: excuse) for the firmware to exist is to (a)<=
br>
&gt; boot operating systems, (b) abstract away some ugly platform-specific<=
br>
&gt; hardware for OS runtime (by providing ACPI and SMBIOS descriptions, an=
d<br>
&gt; a *small* set of runtime services). We can maybe add (c) &quot;root of=
 trust&quot;.<br>
&gt; <br>
&gt; In practice, physical firmware is becoming the hw vendor's OS before<b=
r>
&gt; (and under) your OS, one you cannot replace, and one whose updates can=
<br>
&gt; brick your hardware. Permitting the same feature creep on virtual<br>
&gt; platforms is wrong.<br>
<br>
On the firmware you develop that choice is fine; but there's no reason<br>
to force that restriction onto others.</div>
<div><br>
</div>
<div>I agree that fw has become the vendor OS, but at this point there's no=
 going back.</div>
<div>Utilizing a virtual platform allows us to greatly increase the securit=
y of our code,</div>
<div>could we make this change a Qemu experimental flag, so that fw vendors=
 could</div>
<div>use it at their own risk?<br>
</div>
<div><br>
&gt; &gt; or have to survive configuring lots of hardware; also<br>
&gt; &gt; I'm aware of other companies who are looking at putting big blobs=
<br>
&gt; &gt; of stuff in firmware for open uses;<br>
&gt; <br>
&gt; Key term being &quot;open uses&quot;. Let us see them.<br>
<br>
Well yes, I think we know who we're speaking about here and we're<br>
working on it.<br>
<br>
&gt; &gt; so I don't see a problem with<br>
&gt; &gt; changing this limit from the QEMU side of things.<br>
&gt; <br>
&gt; I do. Software and data always expand to consume all available space,<=
br>
&gt; and it's going to cause a conflict between UEFI features and platform<=
br>
&gt; MMIO sooner or later. Then I'll get the privilege of shuffling around<=
br>
&gt; the crap in OVMF (all of which is &quot;indispensable&quot; or course)=
.<br>
&gt; <br>
&gt; If we ever go down this route, it needs to benefit open source directl=
y<br>
&gt; and significantly.<br>
<br>
Being able to use QEMU to let vendors debug their platform firmware is a<br=
>
perfectly reasonable use of QEMU; maybe not of your OVMF build - we<br>
need to keep the restrictions on the two separate.</div>
<div><br>
</div>
<div>I would hope that continued use of QEMU would encourage us vendors to =
contribute<br>
</div>
<div>more toward improving the open source project. As Dave pointed out, in=
 no way</div>
<div>would anyone be forced (or able) to use vendor fw binaries unless we s=
tarted to</div>
<div>release them as such, which would not be in our best interests, since =
we like to sell hardware.<br>
</div>
<div><br>
Dave<br>
<br>
&gt; Laszlo<br>
-- <br>
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK<br>
</div>
</body>
</html>

--_000_CS1PR8401MB03273F105DE3FA773E2DB2F5F3240CS1PR8401MB0327_--


