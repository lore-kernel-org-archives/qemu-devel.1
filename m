Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84936C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:53:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF4220679
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uMisienA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF4220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHo3p-0006CX-ES
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 07:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sameid@google.com>) id 1iHo21-0005By-Eq
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sameid@google.com>) id 1iHo1y-0005B0-PI
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:51:57 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:46162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sameid@google.com>) id 1iHo1y-00058V-Kb
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:51:54 -0400
Received: by mail-qk1-x743.google.com with SMTP id 201so16339699qkd.13
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 04:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j72W7mJtezSpRvarsO3SjlIei+lH01UimNm8qkVBVEY=;
 b=uMisienAcwftKHei1R9yzOI6o4gLmxzPpGLKj4BjfEsdgiM+lVvcmm1b8UJMDoF1Qa
 fKkp+Q0sY8T8VYZ3a+bHPklTcgu471wZOxgN4ZBLbJK+W5cJHfUWs10kd5btYhoabVJW
 Lw4lDiA0e80hTXHd9/9E1T7iG377fWAsXPpj0TW3lACdwopUARfm6spg1bHPRtGyo4fe
 dp3MRfX3NW5E1Xi4HAxb8cWiYtq/qH9d1ffIj5AGGx8q4FY+q0qDwU5ZjLMLqzNnph+0
 oKrbNkj//Ubu2vv4/fZPMxyZmbX/REj/0atIpQ0MPI7CcibBfJ/8YDRnhw80Jo6vMtHP
 t1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j72W7mJtezSpRvarsO3SjlIei+lH01UimNm8qkVBVEY=;
 b=oyE75g0ywcONSDbTduuoCWeOg3vypYk4kIrvQR6reaQ6scP7jK9cLqt48/9NM6/rs+
 uONwgE5eQRuGgiy6UBbZDPIBzyZckwc5XwMBx9YK3pglwT/15cgxfaU/hvUyLaSAZLxa
 wJa/MNiQwATHVxfo1uJuzMMayvz3BMDj2wOqR3sYeuO8ca+eTnQFdTBr4awmTTGqjp/h
 OnIn1haUWRRW54Jts1I+lYQn24N8pMeLV6sk6WuEyBJf+rkouqJV0h7OH9vkKzGPHfaw
 tW8pl/yQ9v+/AivRlwqLBfPog8scmaDRVmwv9VSyvxUj2SiP7L0P+LQebI9lvlhxf/C4
 NXqg==
X-Gm-Message-State: APjAAAVR0H8Z0slzBV1MfZafq3QQFIuV9JXX5Jsei4tbSNmZRlgXoPZV
 hR3Qj4c/Ad9V3uuq8pVU04PJMfaOtL2UtMumsUeYRA==
X-Google-Smtp-Source: APXvYqwyAkku2vi6fFGHpVRuktdrWL6PbWXIKE5o+GXgevZmhP3+w9klE13iXnFExtdGMR7TmA+Xfu5kyZqrAxUfDDM=
X-Received: by 2002:a37:743:: with SMTP id 64mr29280298qkh.190.1570535511880; 
 Tue, 08 Oct 2019 04:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190925110639.100699-1-sameid@google.com>
 <20190925110639.100699-8-sameid@google.com>
 <ffff9a59-3cbf-8b04-f4e5-8a01dad8d381@redhat.com>
 <7dc7b14c-8e89-4851-6d05-d69b1bf36e3e@redhat.com>
 <92b719a7-3838-b019-cd51-5f5b2120a431@redhat.com>
 <1d863ce2-0e45-63e4-ceb2-d2eb2d9aa03a@redhat.com>
 <CAFr6bU=2B9JcmfJZ25BTYkhnw2V+YAghyAyK9YHto18KRptPAg@mail.gmail.com>
 <1dc0c7cd-cf9f-0c33-04f5-ed8d89119c9f@redhat.com>
In-Reply-To: <1dc0c7cd-cf9f-0c33-04f5-ed8d89119c9f@redhat.com>
From: Sam Eiderman <sameid@google.com>
Date: Tue, 8 Oct 2019 13:51:38 +0200
Message-ID: <CAFr6bUnsxhqBqHgRdw3dtv0rEvfCVn0oM4XD8Vb1xv_UGKvepg@mail.gmail.com>
Subject: Re: [SeaBIOS] [PATCH v7 7/8] bootdevice: FW_CFG interface for LCHS
 values
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, 
 qemu-block@nongnu.org, arbel.moshe@oracle.com, seabios@seabios.org, 
 kraxel@redhat.com, Laszlo Ersek <lersek@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004b6c66059464cb3a"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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

--0000000000004b6c66059464cb3a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2019, 13:34 Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =
wrote:

> Hi Sam,
>
> On 9/29/19 12:13 PM, Sam Eiderman wrote:
> > Philippe, thanks for the fast review,
>
> Fast is not always the friend of careful.
>
> >
> > John, thanks for picking up this hot potato :-)
> >
> > Sam
> >
> > On Thu, Sep 26, 2019 at 10:16 PM Philippe Mathieu-Daud=C3=A9
> > <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
> >
> >     On 9/26/19 9:09 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> >      > On 9/26/19 8:26 PM, John Snow wrote:
> >      >> On 9/26/19 5:57 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> >      >>> Hi Sam,
> >      >>>
> >      >>> On 9/25/19 1:06 PM, Sam Eiderman wrote:
> >      >>>> From: Sam Eiderman <shmuel.eiderman@oracle.com
> >     <mailto:shmuel.eiderman@oracle.com>>
> >      >>>>
> >      >>>> Using fw_cfg, supply logical CHS values directly from QEMU to
> >     the BIOS.
> >      >>>>
> >      >>>> Non-standard logical geometries break under QEMU.
> >      >>>>
> >      >>>> A virtual disk which contains an operating system which
> depends on
> >      >>>> logical geometries (consistent values being reported from BIO=
S
> >     INT13
> >      >>>> AH=3D08) will most likely break under QEMU/SeaBIOS if it has
> >     non-standard
> >      >>>> logical geometries - for example 56 SPT (sectors per track).
> >      >>>> No matter what QEMU will report - SeaBIOS, for large enough
> >     disks - will
> >      >>>> use LBA translation, which will report 63 SPT instead.
> >      >>>>
> >      >>>> In addition we cannot force SeaBIOS to rely on physical
> >     geometries at
> >      >>>> all. A virtio-blk-pci virtual disk with 255 phyiscal heads
> cannot
> >      >>>> report more than 16 physical heads when moved to an IDE
> >     controller,
> >      >>>> since the ATA spec allows a maximum of 16 heads - this is an
> >     artifact of
> >      >>>> virtualization.
> >      >>>>
> >      >>>> By supplying the logical geometries directly we are able to
> >     support such
> >      >>>> "exotic" disks.
> >      >>>>
> >      >>>> We serialize this information in a similar way to the
> "bootorder"
> >      >>>> interface.
> >      >>>> The new fw_cfg entry is "bios-geometry".
> >      >>>>
> >      >>>> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com
> >     <mailto:karl.heubaum@oracle.com>>
> >      >>>> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com
> >     <mailto:arbel.moshe@oracle.com>>
> >      >>>> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com
> >     <mailto:shmuel.eiderman@oracle.com>>
> >      >>>> ---
> >      >>>>  bootdevice.c            | 32 +++++++++++++++++++++++++++++++=
+
> >      >>>>  hw/nvram/fw_cfg.c       | 14 +++++++++++---
> >      >>>>  include/sysemu/sysemu.h |  1 +
> >      >>>>  3 files changed, 44 insertions(+), 3 deletions(-)
> >      >>>>
> >      >>>> diff --git a/bootdevice.c b/bootdevice.c
> >      >>>> index 2b12fb85a4..b034ad7bdc 100644
> >      >>>> --- a/bootdevice.c
> >      >>>> +++ b/bootdevice.c
> >      >>>> @@ -405,3 +405,35 @@ void del_boot_device_lchs(DeviceState
> >     *dev, const char *suffix)
> >      >>>>          }
> >      >>>>      }
> >      >>>>  }
> >      >>>> +
> >      >>>> +/* Serialized as: (device name\0 + lchs struct) x devices */
>
> I suppose the lchs struct is serialized in little-endian.
>

Nice catch, that's just a bad comment, should be removed.
There used to be a struct with 3 uint32_t values, Laszlo pointed out that
there is an endianess problem (this was fixed in v3) later Kevin suggested
to make it a textual interface and the struct was removed (in v4) but the
comment remained.

>
> >      >>>> +char *get_boot_devices_lchs_list(size_t *size)
> >      >>>> +{
> >      >>>> +    FWLCHSEntry *i;
> >      >>>> +    size_t total =3D 0;
> >      >>>> +    char *list =3D NULL;
> >      >>>> +
> >      >>>> +    QTAILQ_FOREACH(i, &fw_lchs, link) {
> >      >>>> +        char *bootpath;
> >      >>>> +        char *chs_string;
> >      >>>> +        size_t len;
> >      >>>> +
> >      >>>> +        bootpath =3D get_boot_device_path(i->dev, false,
> >     i->suffix);
> >      >>>> +        chs_string =3D g_strdup_printf("%s %" PRIu32 " %"
> >     PRIu32 " %" PRIu32,
> >      >>>> +                                     bootpath, i->lcyls,
> >     i->lheads, i->lsecs);
>
> Sam. can you check if you don't need endianness conversion here?
>

Hmm, since this is a textual interface, I believe this should work no?

uint32_t a =3D 4;
g_strdup_printf("%s" PRIu32, a);

Should return "4" no matter the endianess? (Taken care of by glib?)


> >      >>>
> >      >>> Hmm maybe we can g_free(bootpath) directly here.
> >      >>>
> >      >>
> >      >> I think it's okay to do it at the bottom of the loop. No real
> >     benefit to
> >      >> being that eager to free resources in my mind. I expect setup a=
t
> >     the top
> >      >> of a block and teardown at the bottom of a block.
> >      >>
> >      >> Trying to do too much in the middle gets messy in my opinion,
> >     not that
> >      >> it seems to matter here.
> >      >
> >      > No problem.
> >      >
> >      >>>> +
> >      >>>> +        if (total) {
> >      >>>> +            list[total - 1] =3D '\n';
> >      >>>> +        }
> >      >>>> +        len =3D strlen(chs_string) + 1;
> >      >>>> +        list =3D g_realloc(list, total + len);
> >      >>>> +        memcpy(&list[total], chs_string, len);
> >      >>>> +        total +=3D len;
> >      >>>> +        g_free(chs_string);
> >      >>>> +        g_free(bootpath);
> >      >>>> +    }
> >      >>>> +
> >      >>>> +    *size =3D total;
> >      >>>> +
> >      >>>> +    return list;
> >      >>>> +}
> >      >>>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> >      >>>> index 7dc3ac378e..18aff658c0 100644
> >      >>>> --- a/hw/nvram/fw_cfg.c
> >      >>>> +++ b/hw/nvram/fw_cfg.c
> >      >>>> @@ -920,13 +920,21 @@ void *fw_cfg_modify_file(FWCfgState *s,
> >     const char *filename,
> >      >>>>
> >      >>>>  static void fw_cfg_machine_reset(void *opaque)
> >      >>>>  {
> >      >>>> +    MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine(=
));
> >      >>>> +    FWCfgState *s =3D opaque;
> >      >>>>      void *ptr;
> >      >>>>      size_t len;
> >      >>>> -    FWCfgState *s =3D opaque;
> >      >>>> -    char *bootindex =3D get_boot_devices_list(&len);
> >      >>>> +    char *buf;
> >      >>>>
> >      >>>> -    ptr =3D fw_cfg_modify_file(s, "bootorder", (uint8_t
> >     *)bootindex, len);
> >      >>>> +    buf =3D get_boot_devices_list(&len);
> >      >>>> +    ptr =3D fw_cfg_modify_file(s, "bootorder", (uint8_t *)bu=
f,
> >     len);
> >      >>>>      g_free(ptr);
> >      >>>> +
> >      >>>> +    if (!mc->legacy_fw_cfg_order) {
> >      >>>> +        buf =3D get_boot_devices_lchs_list(&len);
> >      >>>> +        ptr =3D fw_cfg_modify_file(s, "bios-geometry", (uint=
8_t
> >     *)buf, len);
> >      >>>
> >      >>> OK. Can you add a test in tests/fw_cfg-test.c please?
> >      >>>
> >      >>
> >      >> :D
> >      >>
> >      >>>> +        g_free(ptr);
> >      >>>> +    }
> >      >>>>  }
> >      >>>>
> >      >>>>  static void fw_cfg_machine_ready(struct Notifier *n, void
> *data)
> >      >>>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.=
h
> >      >>>> index 5bc5c79cbc..80c57fdc4e 100644
> >      >>>> --- a/include/sysemu/sysemu.h
> >      >>>> +++ b/include/sysemu/sysemu.h
> >      >>>> @@ -106,6 +106,7 @@ void validate_bootdevices(const char
> >     *devices, Error **errp);
> >      >>>>  void add_boot_device_lchs(DeviceState *dev, const char
> *suffix,
> >      >>>>                            uint32_t lcyls, uint32_t lheads,
> >     uint32_t lsecs);
> >      >>>>  void del_boot_device_lchs(DeviceState *dev, const char
> *suffix);
> >      >>>> +char *get_boot_devices_lchs_list(size_t *size);
> >      >>>
> >      >>> Please add some documentation. At least 'size' must be non-NUL=
L.
> >      >>>
> >      >>
> >      >> Sure; but I wasn't going to gate on it because this series went
> >     unloved
> >      >> for so long. At this point, a follow-up patch is fine.
> >      >
> >      > OK
> >      >
> >      >>
> >      >>> Ideally you should add doc for the other functions added in 3/=
8
> >      >>> "bootdevice: Add interface to gather LCHS" too.
> >      >>>
> >      >>
> >      >> Same thing here.
> >      >>
> >      >>> John, what do you think about extracting the *boot_device*
> >     functions out
> >      >>> of "sysemu.h"?
> >      >>>
> >      >>
> >      >> Potentially worthwhile; but not critical at the moment. The
> >     source tree
> >      >> is not the best-organized thing as-is and I don't think it's
> fair to
> >      >> hold this series up for much longer for nice-to-haves,
> ultimately.
> >      >>
> >      >> More targeted improvements might avoid the "whose responsibilit=
y
> >     is it
> >      >> to stage this?" hot potato we played with this one; so I'd
> >     rather have
> >      >> smaller follow-up patches handled by the respective maintainers=
.
> >      >
> >      > Sure, fair enough.
> >
> >     I forgot:
> >     Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
> >     <mailto:philmd@redhat.com>>
>
> Meanwhile I withdraw my fast R-b :(
>
> Regards,
>
> Phil.
>

--0000000000004b6c66059464cb3a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Oct 8, 2019, 13:34 Philippe Mathieu-Daud=C3=A9=
 &lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_blank" rel=3D"noreferr=
er">philmd@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">Hi Sam,<br>
<br>
On 9/29/19 12:13 PM, Sam Eiderman wrote:<br>
&gt; Philippe, thanks for the fast review,<br>
<br>
Fast is not always the friend of careful.<br>
<br>
&gt; <br>
&gt; John, thanks for picking up this hot potato :-)<br>
&gt; <br>
&gt; Sam<br>
&gt; <br>
&gt; On Thu, Sep 26, 2019 at 10:16 PM Philippe Mathieu-Daud=C3=A9 <br>
&gt; &lt;<a href=3D"mailto:philmd@redhat.com" rel=3D"noreferrer noreferrer"=
 target=3D"_blank">philmd@redhat.com</a> &lt;mailto:<a href=3D"mailto:philm=
d@redhat.com" rel=3D"noreferrer noreferrer" target=3D"_blank">philmd@redhat=
.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 9/26/19 9:09 PM, Philippe Mathieu-Daud=C3=A9 wro=
te:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On 9/26/19 8:26 PM, John Snow wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; On 9/26/19 5:57 AM, Philippe Mathieu-Daud=
=C3=A9 wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; Hi Sam,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; On 9/25/19 1:06 PM, Sam Eiderman wrot=
e:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; From: Sam Eiderman &lt;<a href=3D=
"mailto:shmuel.eiderman@oracle.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">shmuel.eiderman@oracle.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:shmuel.eiderman@oracle=
.com" rel=3D"noreferrer noreferrer" target=3D"_blank">shmuel.eiderman@oracl=
e.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; Using fw_cfg, supply logical CHS =
values directly from QEMU to<br>
&gt;=C2=A0 =C2=A0 =C2=A0the BIOS.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; Non-standard logical geometries b=
reak under QEMU.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; A virtual disk which contains an =
operating system which depends on<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; logical geometries (consistent va=
lues being reported from BIOS<br>
&gt;=C2=A0 =C2=A0 =C2=A0INT13<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; AH=3D08) will most likely break u=
nder QEMU/SeaBIOS if it has<br>
&gt;=C2=A0 =C2=A0 =C2=A0non-standard<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; logical geometries - for example =
56 SPT (sectors per track).<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; No matter what QEMU will report -=
 SeaBIOS, for large enough<br>
&gt;=C2=A0 =C2=A0 =C2=A0disks - will<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; use LBA translation, which will r=
eport 63 SPT instead.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; In addition we cannot force SeaBI=
OS to rely on physical<br>
&gt;=C2=A0 =C2=A0 =C2=A0geometries at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; all. A virtio-blk-pci virtual dis=
k with 255 phyiscal heads cannot<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; report more than 16 physical head=
s when moved to an IDE<br>
&gt;=C2=A0 =C2=A0 =C2=A0controller,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; since the ATA spec allows a maxim=
um of 16 heads - this is an<br>
&gt;=C2=A0 =C2=A0 =C2=A0artifact of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; virtualization.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; By supplying the logical geometri=
es directly we are able to<br>
&gt;=C2=A0 =C2=A0 =C2=A0support such<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; &quot;exotic&quot; disks.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; We serialize this information in =
a similar way to the &quot;bootorder&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; interface.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; The new fw_cfg entry is &quot;bio=
s-geometry&quot;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; Reviewed-by: Karl Heubaum &lt;<a =
href=3D"mailto:karl.heubaum@oracle.com" rel=3D"noreferrer noreferrer" targe=
t=3D"_blank">karl.heubaum@oracle.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:karl.heubaum@oracle.co=
m" rel=3D"noreferrer noreferrer" target=3D"_blank">karl.heubaum@oracle.com<=
/a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; Reviewed-by: Arbel Moshe &lt;<a h=
ref=3D"mailto:arbel.moshe@oracle.com" rel=3D"noreferrer noreferrer" target=
=3D"_blank">arbel.moshe@oracle.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:arbel.moshe@oracle.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">arbel.moshe@oracle.com</a=
>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; Signed-off-by: Sam Eiderman &lt;<=
a href=3D"mailto:shmuel.eiderman@oracle.com" rel=3D"noreferrer noreferrer" =
target=3D"_blank">shmuel.eiderman@oracle.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:shmuel.eiderman@oracle=
.com" rel=3D"noreferrer noreferrer" target=3D"_blank">shmuel.eiderman@oracl=
e.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;=C2=A0 bootdevice.c=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 32 ++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;=C2=A0 hw/nvram/fw_cfg.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 14 +++++++++++---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;=C2=A0 include/sysemu/sysemu.h |=
=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;=C2=A0 3 files changed, 44 inserti=
ons(+), 3 deletions(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; diff --git a/bootdevice.c b/bootd=
evice.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; index 2b12fb85a4..b034ad7bdc 1006=
44<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; --- a/bootdevice.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +++ b/bootdevice.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; @@ -405,3 +405,35 @@ void del_boo=
t_device_lchs(DeviceState<br>
&gt;=C2=A0 =C2=A0 =C2=A0*dev, const char *suffix)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;=C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +/* Serialized as: (device name\0=
 + lchs struct) x devices */<br>
<br>
I suppose the lchs struct is serialized in little-endian.<br></blockquote><=
/div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Nice catch, that&#=
39;s just a bad comment, should be removed.</div><div dir=3D"auto">There us=
ed to be a struct with 3 uint32_t values, Laszlo pointed out that there is =
an endianess problem (this was fixed in v3) later Kevin suggested to make i=
t a textual interface and the struct was removed (in v4) but the comment re=
mained.</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +char *get_boot_devices_lchs_list=
(size_t *size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 FWLCHSEntry *i;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 size_t total =3D 0=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 char *list =3D NUL=
L;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 QTAILQ_FOREACH(i, =
&amp;fw_lchs, link) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 char=
 *bootpath;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 char=
 *chs_string;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 size=
_t len;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 boot=
path =3D get_boot_device_path(i-&gt;dev, false,<br>
&gt;=C2=A0 =C2=A0 =C2=A0i-&gt;suffix);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 chs_=
string =3D g_strdup_printf(&quot;%s %&quot; PRIu32 &quot; %&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0PRIu32 &quot; %&quot; PRIu32,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0bootpath, i-&gt;lcyls,<br>
&gt;=C2=A0 =C2=A0 =C2=A0i-&gt;lheads, i-&gt;lsecs);<br>
<br>
Sam. can you check if you don&#39;t need endianness conversion here?<br></b=
lockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Hmm, si=
nce this is a textual interface, I believe this should work no?</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">uint32_t a =3D 4;</div><div dir=3D"=
auto">g_strdup_printf(&quot;%s&quot; PRIu32, a);</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">Should return &quot;4&quot; no matter the endianes=
s? (Taken care of by glib?)</div><div dir=3D"auto"><br></div><div dir=3D"au=
to"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; Hmm maybe we can g_free(bootpath) dir=
ectly here.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; I think it&#39;s okay to do it at the bot=
tom of the loop. No real<br>
&gt;=C2=A0 =C2=A0 =C2=A0benefit to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; being that eager to free resources in my =
mind. I expect setup at<br>
&gt;=C2=A0 =C2=A0 =C2=A0the top<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; of a block and teardown at the bottom of =
a block.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; Trying to do too much in the middle gets =
messy in my opinion,<br>
&gt;=C2=A0 =C2=A0 =C2=A0not that<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; it seems to matter here.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; No problem.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
total) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 list[total - 1] =3D &#39;\n&#39;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =
=3D strlen(chs_string) + 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 list=
 =3D g_realloc(list, total + len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memc=
py(&amp;list[total], chs_string, len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tota=
l +=3D len;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_fr=
ee(chs_string);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_fr=
ee(bootpath);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 *size =3D total;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 return list;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; diff --git a/hw/nvram/fw_cfg.c b/=
hw/nvram/fw_cfg.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; index 7dc3ac378e..18aff658c0 1006=
44<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; --- a/hw/nvram/fw_cfg.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +++ b/hw/nvram/fw_cfg.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; @@ -920,13 +920,21 @@ void *fw_cf=
g_modify_file(FWCfgState *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0const char *filename,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;=C2=A0 static void fw_cfg_machine_=
reset(void *opaque)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 MachineClass *mc =
=3D MACHINE_GET_CLASS(qdev_get_machine());<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 FWCfgState *s =3D =
opaque;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 void *ptr;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 size_t len;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 FWCfgState *s =3D =
opaque;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 char *bootindex =
=3D get_boot_devices_list(&amp;len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 char *buf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 ptr =3D fw_cfg_mod=
ify_file(s, &quot;bootorder&quot;, (uint8_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0*)bootindex, len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 buf =3D get_boot_d=
evices_list(&amp;len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 ptr =3D fw_cfg_mod=
ify_file(s, &quot;bootorder&quot;, (uint8_t *)buf,<br>
&gt;=C2=A0 =C2=A0 =C2=A0len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 g_free(ptr);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (!mc-&gt;legacy=
_fw_cfg_order) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 buf =
=3D get_boot_devices_lchs_list(&amp;len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptr =
=3D fw_cfg_modify_file(s, &quot;bios-geometry&quot;, (uint8_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0*)buf, len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; OK. Can you add a test in tests/fw_cf=
g-test.c please?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; :D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_fr=
ee(ptr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;=C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;=C2=A0 static void fw_cfg_machine_=
ready(struct Notifier *n, void *data)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; diff --git a/include/sysemu/sysem=
u.h b/include/sysemu/sysemu.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; index 5bc5c79cbc..80c57fdc4e 1006=
44<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; --- a/include/sysemu/sysemu.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +++ b/include/sysemu/sysemu.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; @@ -106,6 +106,7 @@ void validate=
_bootdevices(const char<br>
&gt;=C2=A0 =C2=A0 =C2=A0*devices, Error **errp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;=C2=A0 void add_boot_device_lchs(D=
eviceState *dev, const char *suffix,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t lc=
yls, uint32_t lheads,<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t lsecs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;=C2=A0 void del_boot_device_lchs(D=
eviceState *dev, const char *suffix);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; +char *get_boot_devices_lchs_list=
(size_t *size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; Please add some documentation. At lea=
st &#39;size&#39; must be non-NULL.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; Sure; but I wasn&#39;t going to gate on i=
t because this series went<br>
&gt;=C2=A0 =C2=A0 =C2=A0unloved<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; for so long. At this point, a follow-up p=
atch is fine.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; OK<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; Ideally you should add doc for the ot=
her functions added in 3/8<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; &quot;bootdevice: Add interface to ga=
ther LCHS&quot; too.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; Same thing here.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; John, what do you think about extract=
ing the *boot_device*<br>
&gt;=C2=A0 =C2=A0 =C2=A0functions out<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; of &quot;sysemu.h&quot;?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; Potentially worthwhile; but not critical =
at the moment. The<br>
&gt;=C2=A0 =C2=A0 =C2=A0source tree<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; is not the best-organized thing as-is and=
 I don&#39;t think it&#39;s fair to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; hold this series up for much longer for n=
ice-to-haves, ultimately.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; More targeted improvements might avoid th=
e &quot;whose responsibility<br>
&gt;=C2=A0 =C2=A0 =C2=A0is it<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; to stage this?&quot; hot potato we played=
 with this one; so I&#39;d<br>
&gt;=C2=A0 =C2=A0 =C2=A0rather have<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; smaller follow-up patches handled by the =
respective maintainers.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Sure, fair enough.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I forgot:<br>
&gt;=C2=A0 =C2=A0 =C2=A0Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a hre=
f=3D"mailto:philmd@redhat.com" rel=3D"noreferrer noreferrer" target=3D"_bla=
nk">philmd@redhat.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:philmd@redhat.com" rel=
=3D"noreferrer noreferrer" target=3D"_blank">philmd@redhat.com</a>&gt;&gt;<=
br>
<br>
Meanwhile I withdraw my fast R-b :(<br>
<br>
Regards,<br>
<br>
Phil.<br>
</blockquote></div></div></div>

--0000000000004b6c66059464cb3a--

