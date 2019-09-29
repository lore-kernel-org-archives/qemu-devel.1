Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F72C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 10:15:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F22C207FA
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 10:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hcUKmNoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F22C207FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEWEu-0007EL-Ku
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 06:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sameid@google.com>) id 1iEWDG-0006WA-Nq
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 06:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sameid@google.com>) id 1iEWDE-0002x8-Hc
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 06:13:58 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833]:41283)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sameid@google.com>) id 1iEWDE-0002wd-7X
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 06:13:56 -0400
Received: by mail-qt1-x833.google.com with SMTP id n1so13064451qtp.8
 for <qemu-devel@nongnu.org>; Sun, 29 Sep 2019 03:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1S2rWDShDmLsLisblcxsE+96uODVXgSF79YeIZ2vNA4=;
 b=hcUKmNocuCp5zM+W+IfLcILGNCpOp84Pk28V59nAZTn76oxxTVdDlRuAbMCMTP4uw7
 +vYb6WulqW1a0YDIG3NysaagARA1Pekyoin5mnwKuw9L84Gd4ygoNQN4lLscTu3KDCqS
 A4ebNipNwCElE1NL7O4ZXTxeg5HzkMYNXEczUi6ZKoIzPcsVARTre+/8Cj12lNsRS+9r
 4DXXMu6P+nIblzAKI/55Y1tTIpTltwNyif9a0Q5dumXHWAyz662Fsi3WG/Y3FFGemXsp
 CBJXnHmabz7TKuCLmR2M+RKcPxxVTwesE9wkzJjwcpCYJJDwDBneT/jUTSTuvxCH4jqP
 NmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1S2rWDShDmLsLisblcxsE+96uODVXgSF79YeIZ2vNA4=;
 b=T+DPmO3a5/vSkNDsNroeT6EqRu2Eqi8apAkzHr+rf/X06xOyrSHdu8bXW3jUWDPY6U
 U7k0BwySSDukS7akNVud0jV7MaipiO2gqlKUzOm7dChERmdtwbTpY/J1/dbRoInyROtc
 MtrrBYdMvUQzMro3GLxdTahlPg5cpdRpCQMRaOhrPBaTlfI3dOY5U+zW+laXQWe4p5H7
 SD+W90DGi8g6QJCL2yGmm4kNk5RaF6CUrTTag9+fMeBmgTQ4BVq2mxZPUljlF9zN0sE3
 lXnqG9j9wtNAVX7tiqAnBqDTQh+OH6xn7AL4jjxpfP1l/q5LAvBu6plEEtiKNM/DrEBT
 5wNg==
X-Gm-Message-State: APjAAAW+2VoBEJ5j4TVHZDZDn7a8maEpaoNDGi68IyBxL8/FmI0YIxZC
 g6XwckPqDqlgBTFBzk7PsU0BT/h/s8K2lxkMxJvsOQ==
X-Google-Smtp-Source: APXvYqyqPf0ne2sPUTSfl93DCesn9grP/iHRvV/QrxkvUJsUEj6gdaQBayoPcVcz6VpwWOnF2RjLNgRirF9xa9x0ebU=
X-Received: by 2002:ac8:611a:: with SMTP id a26mr19923477qtm.68.1569752034403; 
 Sun, 29 Sep 2019 03:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190925110639.100699-1-sameid@google.com>
 <20190925110639.100699-8-sameid@google.com>
 <ffff9a59-3cbf-8b04-f4e5-8a01dad8d381@redhat.com>
 <7dc7b14c-8e89-4851-6d05-d69b1bf36e3e@redhat.com>
 <92b719a7-3838-b019-cd51-5f5b2120a431@redhat.com>
 <1d863ce2-0e45-63e4-ceb2-d2eb2d9aa03a@redhat.com>
In-Reply-To: <1d863ce2-0e45-63e4-ceb2-d2eb2d9aa03a@redhat.com>
From: Sam Eiderman <sameid@google.com>
Date: Sun, 29 Sep 2019 13:13:43 +0300
Message-ID: <CAFr6bU=2B9JcmfJZ25BTYkhnw2V+YAghyAyK9YHto18KRptPAg@mail.gmail.com>
Subject: Re: [SeaBIOS] [PATCH v7 7/8] bootdevice: FW_CFG interface for LCHS
 values
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, 
 qemu-block@nongnu.org, arbel.moshe@oracle.com, seabios@seabios.org, 
 kraxel@redhat.com, Laszlo Ersek <lersek@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000065b1b10593ae6078"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::833
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

--00000000000065b1b10593ae6078
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Philippe, thanks for the fast review,

John, thanks for picking up this hot potato :-)

Sam

On Thu, Sep 26, 2019 at 10:16 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com>
wrote:

> On 9/26/19 9:09 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 9/26/19 8:26 PM, John Snow wrote:
> >> On 9/26/19 5:57 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> Hi Sam,
> >>>
> >>> On 9/25/19 1:06 PM, Sam Eiderman wrote:
> >>>> From: Sam Eiderman <shmuel.eiderman@oracle.com>
> >>>>
> >>>> Using fw_cfg, supply logical CHS values directly from QEMU to the
> BIOS.
> >>>>
> >>>> Non-standard logical geometries break under QEMU.
> >>>>
> >>>> A virtual disk which contains an operating system which depends on
> >>>> logical geometries (consistent values being reported from BIOS INT13
> >>>> AH=3D08) will most likely break under QEMU/SeaBIOS if it has
> non-standard
> >>>> logical geometries - for example 56 SPT (sectors per track).
> >>>> No matter what QEMU will report - SeaBIOS, for large enough disks -
> will
> >>>> use LBA translation, which will report 63 SPT instead.
> >>>>
> >>>> In addition we cannot force SeaBIOS to rely on physical geometries a=
t
> >>>> all. A virtio-blk-pci virtual disk with 255 phyiscal heads cannot
> >>>> report more than 16 physical heads when moved to an IDE controller,
> >>>> since the ATA spec allows a maximum of 16 heads - this is an artifac=
t
> of
> >>>> virtualization.
> >>>>
> >>>> By supplying the logical geometries directly we are able to support
> such
> >>>> "exotic" disks.
> >>>>
> >>>> We serialize this information in a similar way to the "bootorder"
> >>>> interface.
> >>>> The new fw_cfg entry is "bios-geometry".
> >>>>
> >>>> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> >>>> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
> >>>> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
> >>>> ---
> >>>>  bootdevice.c            | 32 ++++++++++++++++++++++++++++++++
> >>>>  hw/nvram/fw_cfg.c       | 14 +++++++++++---
> >>>>  include/sysemu/sysemu.h |  1 +
> >>>>  3 files changed, 44 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/bootdevice.c b/bootdevice.c
> >>>> index 2b12fb85a4..b034ad7bdc 100644
> >>>> --- a/bootdevice.c
> >>>> +++ b/bootdevice.c
> >>>> @@ -405,3 +405,35 @@ void del_boot_device_lchs(DeviceState *dev,
> const char *suffix)
> >>>>          }
> >>>>      }
> >>>>  }
> >>>> +
> >>>> +/* Serialized as: (device name\0 + lchs struct) x devices */
> >>>> +char *get_boot_devices_lchs_list(size_t *size)
> >>>> +{
> >>>> +    FWLCHSEntry *i;
> >>>> +    size_t total =3D 0;
> >>>> +    char *list =3D NULL;
> >>>> +
> >>>> +    QTAILQ_FOREACH(i, &fw_lchs, link) {
> >>>> +        char *bootpath;
> >>>> +        char *chs_string;
> >>>> +        size_t len;
> >>>> +
> >>>> +        bootpath =3D get_boot_device_path(i->dev, false, i->suffix)=
;
> >>>> +        chs_string =3D g_strdup_printf("%s %" PRIu32 " %" PRIu32 " =
%"
> PRIu32,
> >>>> +                                     bootpath, i->lcyls, i->lheads,
> i->lsecs);
> >>>
> >>> Hmm maybe we can g_free(bootpath) directly here.
> >>>
> >>
> >> I think it's okay to do it at the bottom of the loop. No real benefit =
to
> >> being that eager to free resources in my mind. I expect setup at the t=
op
> >> of a block and teardown at the bottom of a block.
> >>
> >> Trying to do too much in the middle gets messy in my opinion, not that
> >> it seems to matter here.
> >
> > No problem.
> >
> >>>> +
> >>>> +        if (total) {
> >>>> +            list[total - 1] =3D '\n';
> >>>> +        }
> >>>> +        len =3D strlen(chs_string) + 1;
> >>>> +        list =3D g_realloc(list, total + len);
> >>>> +        memcpy(&list[total], chs_string, len);
> >>>> +        total +=3D len;
> >>>> +        g_free(chs_string);
> >>>> +        g_free(bootpath);
> >>>> +    }
> >>>> +
> >>>> +    *size =3D total;
> >>>> +
> >>>> +    return list;
> >>>> +}
> >>>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> >>>> index 7dc3ac378e..18aff658c0 100644
> >>>> --- a/hw/nvram/fw_cfg.c
> >>>> +++ b/hw/nvram/fw_cfg.c
> >>>> @@ -920,13 +920,21 @@ void *fw_cfg_modify_file(FWCfgState *s, const
> char *filename,
> >>>>
> >>>>  static void fw_cfg_machine_reset(void *opaque)
> >>>>  {
> >>>> +    MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
> >>>> +    FWCfgState *s =3D opaque;
> >>>>      void *ptr;
> >>>>      size_t len;
> >>>> -    FWCfgState *s =3D opaque;
> >>>> -    char *bootindex =3D get_boot_devices_list(&len);
> >>>> +    char *buf;
> >>>>
> >>>> -    ptr =3D fw_cfg_modify_file(s, "bootorder", (uint8_t *)bootindex=
,
> len);
> >>>> +    buf =3D get_boot_devices_list(&len);
> >>>> +    ptr =3D fw_cfg_modify_file(s, "bootorder", (uint8_t *)buf, len)=
;
> >>>>      g_free(ptr);
> >>>> +
> >>>> +    if (!mc->legacy_fw_cfg_order) {
> >>>> +        buf =3D get_boot_devices_lchs_list(&len);
> >>>> +        ptr =3D fw_cfg_modify_file(s, "bios-geometry", (uint8_t *)b=
uf,
> len);
> >>>
> >>> OK. Can you add a test in tests/fw_cfg-test.c please?
> >>>
> >>
> >> :D
> >>
> >>>> +        g_free(ptr);
> >>>> +    }
> >>>>  }
> >>>>
> >>>>  static void fw_cfg_machine_ready(struct Notifier *n, void *data)
> >>>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> >>>> index 5bc5c79cbc..80c57fdc4e 100644
> >>>> --- a/include/sysemu/sysemu.h
> >>>> +++ b/include/sysemu/sysemu.h
> >>>> @@ -106,6 +106,7 @@ void validate_bootdevices(const char *devices,
> Error **errp);
> >>>>  void add_boot_device_lchs(DeviceState *dev, const char *suffix,
> >>>>                            uint32_t lcyls, uint32_t lheads, uint32_t
> lsecs);
> >>>>  void del_boot_device_lchs(DeviceState *dev, const char *suffix);
> >>>> +char *get_boot_devices_lchs_list(size_t *size);
> >>>
> >>> Please add some documentation. At least 'size' must be non-NULL.
> >>>
> >>
> >> Sure; but I wasn't going to gate on it because this series went unlove=
d
> >> for so long. At this point, a follow-up patch is fine.
> >
> > OK
> >
> >>
> >>> Ideally you should add doc for the other functions added in 3/8
> >>> "bootdevice: Add interface to gather LCHS" too.
> >>>
> >>
> >> Same thing here.
> >>
> >>> John, what do you think about extracting the *boot_device* functions
> out
> >>> of "sysemu.h"?
> >>>
> >>
> >> Potentially worthwhile; but not critical at the moment. The source tre=
e
> >> is not the best-organized thing as-is and I don't think it's fair to
> >> hold this series up for much longer for nice-to-haves, ultimately.
> >>
> >> More targeted improvements might avoid the "whose responsibility is it
> >> to stage this?" hot potato we played with this one; so I'd rather have
> >> smaller follow-up patches handled by the respective maintainers.
> >
> > Sure, fair enough.
>
> I forgot:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>

--00000000000065b1b10593ae6078
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Philippe, thanks for the fast review,<div><br></div><div>J=
ohn, thanks for picking up this hot potato :-)</div><div><br></div><div>Sam=
</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">On Thu, Sep 26, 2019 at 10:16 PM Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">On 9/26/19 9:09 PM, Phili=
ppe Mathieu-Daud=C3=A9 wrote:<br>
&gt; On 9/26/19 8:26 PM, John Snow wrote:<br>
&gt;&gt; On 9/26/19 5:57 AM, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt;&gt;&gt; Hi Sam,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On 9/25/19 1:06 PM, Sam Eiderman wrote:<br>
&gt;&gt;&gt;&gt; From: Sam Eiderman &lt;<a href=3D"mailto:shmuel.eiderman@o=
racle.com" target=3D"_blank">shmuel.eiderman@oracle.com</a>&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Using fw_cfg, supply logical CHS values directly from QEMU=
 to the BIOS.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Non-standard logical geometries break under QEMU.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; A virtual disk which contains an operating system which de=
pends on<br>
&gt;&gt;&gt;&gt; logical geometries (consistent values being reported from =
BIOS INT13<br>
&gt;&gt;&gt;&gt; AH=3D08) will most likely break under QEMU/SeaBIOS if it h=
as non-standard<br>
&gt;&gt;&gt;&gt; logical geometries - for example 56 SPT (sectors per track=
).<br>
&gt;&gt;&gt;&gt; No matter what QEMU will report - SeaBIOS, for large enoug=
h disks - will<br>
&gt;&gt;&gt;&gt; use LBA translation, which will report 63 SPT instead.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; In addition we cannot force SeaBIOS to rely on physical ge=
ometries at<br>
&gt;&gt;&gt;&gt; all. A virtio-blk-pci virtual disk with 255 phyiscal heads=
 cannot<br>
&gt;&gt;&gt;&gt; report more than 16 physical heads when moved to an IDE co=
ntroller,<br>
&gt;&gt;&gt;&gt; since the ATA spec allows a maximum of 16 heads - this is =
an artifact of<br>
&gt;&gt;&gt;&gt; virtualization.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; By supplying the logical geometries directly we are able t=
o support such<br>
&gt;&gt;&gt;&gt; &quot;exotic&quot; disks.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; We serialize this information in a similar way to the &quo=
t;bootorder&quot;<br>
&gt;&gt;&gt;&gt; interface.<br>
&gt;&gt;&gt;&gt; The new fw_cfg entry is &quot;bios-geometry&quot;.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Reviewed-by: Karl Heubaum &lt;<a href=3D"mailto:karl.heuba=
um@oracle.com" target=3D"_blank">karl.heubaum@oracle.com</a>&gt;<br>
&gt;&gt;&gt;&gt; Reviewed-by: Arbel Moshe &lt;<a href=3D"mailto:arbel.moshe=
@oracle.com" target=3D"_blank">arbel.moshe@oracle.com</a>&gt;<br>
&gt;&gt;&gt;&gt; Signed-off-by: Sam Eiderman &lt;<a href=3D"mailto:shmuel.e=
iderman@oracle.com" target=3D"_blank">shmuel.eiderman@oracle.com</a>&gt;<br=
>
&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;=C2=A0 bootdevice.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 32 ++++++++++++++++++++++++++++++++<br>
&gt;&gt;&gt;&gt;=C2=A0 hw/nvram/fw_cfg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 14 +++=
++++++++---<br>
&gt;&gt;&gt;&gt;=C2=A0 include/sysemu/sysemu.h |=C2=A0 1 +<br>
&gt;&gt;&gt;&gt;=C2=A0 3 files changed, 44 insertions(+), 3 deletions(-)<br=
>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; diff --git a/bootdevice.c b/bootdevice.c<br>
&gt;&gt;&gt;&gt; index 2b12fb85a4..b034ad7bdc 100644<br>
&gt;&gt;&gt;&gt; --- a/bootdevice.c<br>
&gt;&gt;&gt;&gt; +++ b/bootdevice.c<br>
&gt;&gt;&gt;&gt; @@ -405,3 +405,35 @@ void del_boot_device_lchs(DeviceState=
 *dev, const char *suffix)<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;=C2=A0 }<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +/* Serialized as: (device name\0 + lchs struct) x devices=
 */<br>
&gt;&gt;&gt;&gt; +char *get_boot_devices_lchs_list(size_t *size)<br>
&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 FWLCHSEntry *i;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 size_t total =3D 0;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 char *list =3D NULL;<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 QTAILQ_FOREACH(i, &amp;fw_lchs, link) {<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *bootpath;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *chs_string;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t len;<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bootpath =3D get_boot_device_=
path(i-&gt;dev, false, i-&gt;suffix);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 chs_string =3D g_strdup_print=
f(&quot;%s %&quot; PRIu32 &quot; %&quot; PRIu32 &quot; %&quot; PRIu32,<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0bootpath, i-&gt;lcyls, i-&gt;lheads, i-&gt;lsecs);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Hmm maybe we can g_free(bootpath) directly here.<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I think it&#39;s okay to do it at the bottom of the loop. No real =
benefit to<br>
&gt;&gt; being that eager to free resources in my mind. I expect setup at t=
he top<br>
&gt;&gt; of a block and teardown at the bottom of a block.<br>
&gt;&gt;<br>
&gt;&gt; Trying to do too much in the middle gets messy in my opinion, not =
that<br>
&gt;&gt; it seems to matter here.<br>
&gt; <br>
&gt; No problem.<br>
&gt; <br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (total) {<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list[total - 1]=
 =3D &#39;\n&#39;;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D strlen(chs_string) + =
1;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 list =3D g_realloc(list, tota=
l + len);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(&amp;list[total], chs_=
string, len);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 total +=3D len;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(chs_string);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(bootpath);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 *size =3D total;<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 return list;<br>
&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt; diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c<br>
&gt;&gt;&gt;&gt; index 7dc3ac378e..18aff658c0 100644<br>
&gt;&gt;&gt;&gt; --- a/hw/nvram/fw_cfg.c<br>
&gt;&gt;&gt;&gt; +++ b/hw/nvram/fw_cfg.c<br>
&gt;&gt;&gt;&gt; @@ -920,13 +920,21 @@ void *fw_cfg_modify_file(FWCfgState =
*s, const char *filename,<br>
&gt;&gt;&gt;&gt;=C2=A0 <br>
&gt;&gt;&gt;&gt;=C2=A0 static void fw_cfg_machine_reset(void *opaque)<br>
&gt;&gt;&gt;&gt;=C2=A0 {<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 MachineClass *mc =3D MACHINE_GET_CLASS(qdev=
_get_machine());<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 FWCfgState *s =3D opaque;<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 void *ptr;<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 size_t len;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 FWCfgState *s =3D opaque;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 char *bootindex =3D get_boot_devices_list(&=
amp;len);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 char *buf;<br>
&gt;&gt;&gt;&gt;=C2=A0 <br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 ptr =3D fw_cfg_modify_file(s, &quot;bootord=
er&quot;, (uint8_t *)bootindex, len);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 buf =3D get_boot_devices_list(&amp;len);<br=
>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 ptr =3D fw_cfg_modify_file(s, &quot;bootord=
er&quot;, (uint8_t *)buf, len);<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 g_free(ptr);<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (!mc-&gt;legacy_fw_cfg_order) {<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 buf =3D get_boot_devices_lchs=
_list(&amp;len);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptr =3D fw_cfg_modify_file(s,=
 &quot;bios-geometry&quot;, (uint8_t *)buf, len);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; OK. Can you add a test in tests/fw_cfg-test.c please?<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; :D<br>
&gt;&gt;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(ptr);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;=C2=A0 }<br>
&gt;&gt;&gt;&gt;=C2=A0 <br>
&gt;&gt;&gt;&gt;=C2=A0 static void fw_cfg_machine_ready(struct Notifier *n,=
 void *data)<br>
&gt;&gt;&gt;&gt; diff --git a/include/sysemu/sysemu.h b/include/sysemu/syse=
mu.h<br>
&gt;&gt;&gt;&gt; index 5bc5c79cbc..80c57fdc4e 100644<br>
&gt;&gt;&gt;&gt; --- a/include/sysemu/sysemu.h<br>
&gt;&gt;&gt;&gt; +++ b/include/sysemu/sysemu.h<br>
&gt;&gt;&gt;&gt; @@ -106,6 +106,7 @@ void validate_bootdevices(const char *=
devices, Error **errp);<br>
&gt;&gt;&gt;&gt;=C2=A0 void add_boot_device_lchs(DeviceState *dev, const ch=
ar *suffix,<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t lcyls, uint32_t lheads, uin=
t32_t lsecs);<br>
&gt;&gt;&gt;&gt;=C2=A0 void del_boot_device_lchs(DeviceState *dev, const ch=
ar *suffix);<br>
&gt;&gt;&gt;&gt; +char *get_boot_devices_lchs_list(size_t *size);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Please add some documentation. At least &#39;size&#39; must be=
 non-NULL.<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Sure; but I wasn&#39;t going to gate on it because this series wen=
t unloved<br>
&gt;&gt; for so long. At this point, a follow-up patch is fine.<br>
&gt; <br>
&gt; OK<br>
&gt; <br>
&gt;&gt;<br>
&gt;&gt;&gt; Ideally you should add doc for the other functions added in 3/=
8<br>
&gt;&gt;&gt; &quot;bootdevice: Add interface to gather LCHS&quot; too.<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Same thing here.<br>
&gt;&gt;<br>
&gt;&gt;&gt; John, what do you think about extracting the *boot_device* fun=
ctions out<br>
&gt;&gt;&gt; of &quot;sysemu.h&quot;?<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Potentially worthwhile; but not critical at the moment. The source=
 tree<br>
&gt;&gt; is not the best-organized thing as-is and I don&#39;t think it&#39=
;s fair to<br>
&gt;&gt; hold this series up for much longer for nice-to-haves, ultimately.=
<br>
&gt;&gt;<br>
&gt;&gt; More targeted improvements might avoid the &quot;whose responsibil=
ity is it<br>
&gt;&gt; to stage this?&quot; hot potato we played with this one; so I&#39;=
d rather have<br>
&gt;&gt; smaller follow-up patches handled by the respective maintainers.<b=
r>
&gt; <br>
&gt; Sure, fair enough.<br>
<br>
I forgot:<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redha=
t.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
</blockquote></div>

--00000000000065b1b10593ae6078--

