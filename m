Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACC7FA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 11:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6AF020854
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 11:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nyBQdNED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6AF020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKh6e-0005RZ-BP
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 07:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sameid@google.com>) id 1iKh4w-0004SH-Kz
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:02:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sameid@google.com>) id 1iKh4u-0005uD-SX
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:02:54 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:36228)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sameid@google.com>) id 1iKh4u-0005ty-Km
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:02:52 -0400
Received: by mail-qk1-x741.google.com with SMTP id y189so22317893qkc.3
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 04:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vgnNsYi5RZ+7McE18uMjrGwKc4YB8zqLpgtvoRPPOPY=;
 b=nyBQdNEDyCaF4jhGZsmN0BOiFKs2xyOtRo1HsnI7pu2lOmWKoEb5kPARAK+hUpXZD7
 MMQkFU9p/DJoZ95yoUTWCe3JRjd14aFw3vKdUXC/axNQovd6lMf/SyTbzy0LvERmjBwO
 fRCUdteTrLqC4WWdVa8ZMSDAI5ipbjzTcN3wf431niM9wmqt5HzOpePugV2WMfheDOWf
 llAYfSO3KaO1A+OA3+Xt6PEUMrkOA8Gt5XFdDzpkY286ivFhs7UNLKMGog2V1cTKCLjq
 82umRqwnUM1eJr2+xqUh01qlWjZZuJ4VJW1TAiYNvCIyDRIoY+Ao4HKhwkCFHdoNPVpX
 rJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vgnNsYi5RZ+7McE18uMjrGwKc4YB8zqLpgtvoRPPOPY=;
 b=VjjPyKT+wmVqUnVZymgyrIP8lNDBAGzeio/wGrht7+cp0qnZMPQYDusz8BDPRKtdL/
 40Zm5brsIhucX8cfGpg/WLfwm4pi6ArxdpKPGNNYh8qLgsQOCtyzqe+F+7btzUoj9KlY
 M8zHF5Xj8GjqpbrkXs8rinDmPoyGFu9qCUeeR5y1rcEONPKUvl09WlHNy3zDp/i7ZtG5
 TM9XQ0pzF5rpN+84VMwEXAQubn7a/pJJ6ajGrCQ7eDa9b3HJ7UnDnpByWdYlf1BpTzb7
 I8Gm56xl+uDm3aptKk/heYlCdGi2TjZ+Z4hxxgrZhszg2mWBjeKC48gvtjc2V2BDvCyZ
 GqlQ==
X-Gm-Message-State: APjAAAWdcGeVaLnHBop0Y7pkBHexq6B/kndynsoHiepMYP4xNbGU5OZN
 Qh+qdlcFfE+7hVrka7rVlZlgSi/gWOvq6nPQHT7b0g==
X-Google-Smtp-Source: APXvYqy1ZEOvjkLcN7lTo4WPo7ZI7KpQwYk8vWnnXgBD9EgtfoJed0NmG1rujmZAE2tgQfFo6TXayTGML2oiFykeX1w=
X-Received: by 2002:a05:620a:2f3:: with SMTP id
 a19mr13486098qko.272.1571223770923; 
 Wed, 16 Oct 2019 04:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190925110639.100699-1-sameid@google.com>
 <20190925110639.100699-8-sameid@google.com>
 <ffff9a59-3cbf-8b04-f4e5-8a01dad8d381@redhat.com>
 <7dc7b14c-8e89-4851-6d05-d69b1bf36e3e@redhat.com>
 <92b719a7-3838-b019-cd51-5f5b2120a431@redhat.com>
 <1d863ce2-0e45-63e4-ceb2-d2eb2d9aa03a@redhat.com>
 <CAFr6bU=2B9JcmfJZ25BTYkhnw2V+YAghyAyK9YHto18KRptPAg@mail.gmail.com>
 <1dc0c7cd-cf9f-0c33-04f5-ed8d89119c9f@redhat.com>
 <CAFr6bUnsxhqBqHgRdw3dtv0rEvfCVn0oM4XD8Vb1xv_UGKvepg@mail.gmail.com>
In-Reply-To: <CAFr6bUnsxhqBqHgRdw3dtv0rEvfCVn0oM4XD8Vb1xv_UGKvepg@mail.gmail.com>
From: Sam Eiderman <sameid@google.com>
Date: Wed, 16 Oct 2019 14:02:39 +0300
Message-ID: <CAFr6bUm53A+gBVBRr00XKDkt=GiJ5QSOEEXPFfuUJ2PcLeG04w@mail.gmail.com>
Subject: Re: [SeaBIOS] [PATCH v7 7/8] bootdevice: FW_CFG interface for LCHS
 values
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, 
 qemu-block@nongnu.org, arbel.moshe@oracle.com, seabios@seabios.org, 
 kraxel@redhat.com, Laszlo Ersek <lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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

Gentle Ping,

Philippe, John?

Just wondering if the series is okay, as Gerd pointed out this series
is a blocker for the corresponding changes in SeaBIOS for v 1.13

Sam


On Tue, Oct 8, 2019 at 2:51 PM Sam Eiderman <sameid@google.com> wrote:
>
>
>
> On Tue, Oct 8, 2019, 13:34 Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>>
>> Hi Sam,
>>
>> On 9/29/19 12:13 PM, Sam Eiderman wrote:
>> > Philippe, thanks for the fast review,
>>
>> Fast is not always the friend of careful.
>>
>> >
>> > John, thanks for picking up this hot potato :-)
>> >
>> > Sam
>> >
>> > On Thu, Sep 26, 2019 at 10:16 PM Philippe Mathieu-Daud=C3=A9
>> > <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>> >
>> >     On 9/26/19 9:09 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> >      > On 9/26/19 8:26 PM, John Snow wrote:
>> >      >> On 9/26/19 5:57 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> >      >>> Hi Sam,
>> >      >>>
>> >      >>> On 9/25/19 1:06 PM, Sam Eiderman wrote:
>> >      >>>> From: Sam Eiderman <shmuel.eiderman@oracle.com
>> >     <mailto:shmuel.eiderman@oracle.com>>
>> >      >>>>
>> >      >>>> Using fw_cfg, supply logical CHS values directly from QEMU t=
o
>> >     the BIOS.
>> >      >>>>
>> >      >>>> Non-standard logical geometries break under QEMU.
>> >      >>>>
>> >      >>>> A virtual disk which contains an operating system which depe=
nds on
>> >      >>>> logical geometries (consistent values being reported from BI=
OS
>> >     INT13
>> >      >>>> AH=3D08) will most likely break under QEMU/SeaBIOS if it has
>> >     non-standard
>> >      >>>> logical geometries - for example 56 SPT (sectors per track).
>> >      >>>> No matter what QEMU will report - SeaBIOS, for large enough
>> >     disks - will
>> >      >>>> use LBA translation, which will report 63 SPT instead.
>> >      >>>>
>> >      >>>> In addition we cannot force SeaBIOS to rely on physical
>> >     geometries at
>> >      >>>> all. A virtio-blk-pci virtual disk with 255 phyiscal heads c=
annot
>> >      >>>> report more than 16 physical heads when moved to an IDE
>> >     controller,
>> >      >>>> since the ATA spec allows a maximum of 16 heads - this is an
>> >     artifact of
>> >      >>>> virtualization.
>> >      >>>>
>> >      >>>> By supplying the logical geometries directly we are able to
>> >     support such
>> >      >>>> "exotic" disks.
>> >      >>>>
>> >      >>>> We serialize this information in a similar way to the "booto=
rder"
>> >      >>>> interface.
>> >      >>>> The new fw_cfg entry is "bios-geometry".
>> >      >>>>
>> >      >>>> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com
>> >     <mailto:karl.heubaum@oracle.com>>
>> >      >>>> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com
>> >     <mailto:arbel.moshe@oracle.com>>
>> >      >>>> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com
>> >     <mailto:shmuel.eiderman@oracle.com>>
>> >      >>>> ---
>> >      >>>>  bootdevice.c            | 32 ++++++++++++++++++++++++++++++=
++
>> >      >>>>  hw/nvram/fw_cfg.c       | 14 +++++++++++---
>> >      >>>>  include/sysemu/sysemu.h |  1 +
>> >      >>>>  3 files changed, 44 insertions(+), 3 deletions(-)
>> >      >>>>
>> >      >>>> diff --git a/bootdevice.c b/bootdevice.c
>> >      >>>> index 2b12fb85a4..b034ad7bdc 100644
>> >      >>>> --- a/bootdevice.c
>> >      >>>> +++ b/bootdevice.c
>> >      >>>> @@ -405,3 +405,35 @@ void del_boot_device_lchs(DeviceState
>> >     *dev, const char *suffix)
>> >      >>>>          }
>> >      >>>>      }
>> >      >>>>  }
>> >      >>>> +
>> >      >>>> +/* Serialized as: (device name\0 + lchs struct) x devices *=
/
>>
>> I suppose the lchs struct is serialized in little-endian.
>
>
> Nice catch, that's just a bad comment, should be removed.
> There used to be a struct with 3 uint32_t values, Laszlo pointed out that=
 there is an endianess problem (this was fixed in v3) later Kevin suggested=
 to make it a textual interface and the struct was removed (in v4) but the =
comment remained.
>>
>>
>> >      >>>> +char *get_boot_devices_lchs_list(size_t *size)
>> >      >>>> +{
>> >      >>>> +    FWLCHSEntry *i;
>> >      >>>> +    size_t total =3D 0;
>> >      >>>> +    char *list =3D NULL;
>> >      >>>> +
>> >      >>>> +    QTAILQ_FOREACH(i, &fw_lchs, link) {
>> >      >>>> +        char *bootpath;
>> >      >>>> +        char *chs_string;
>> >      >>>> +        size_t len;
>> >      >>>> +
>> >      >>>> +        bootpath =3D get_boot_device_path(i->dev, false,
>> >     i->suffix);
>> >      >>>> +        chs_string =3D g_strdup_printf("%s %" PRIu32 " %"
>> >     PRIu32 " %" PRIu32,
>> >      >>>> +                                     bootpath, i->lcyls,
>> >     i->lheads, i->lsecs);
>>
>> Sam. can you check if you don't need endianness conversion here?
>
>
> Hmm, since this is a textual interface, I believe this should work no?
>
> uint32_t a =3D 4;
> g_strdup_printf("%s" PRIu32, a);
>
> Should return "4" no matter the endianess? (Taken care of by glib?)
>
>>
>> >      >>>
>> >      >>> Hmm maybe we can g_free(bootpath) directly here.
>> >      >>>
>> >      >>
>> >      >> I think it's okay to do it at the bottom of the loop. No real
>> >     benefit to
>> >      >> being that eager to free resources in my mind. I expect setup =
at
>> >     the top
>> >      >> of a block and teardown at the bottom of a block.
>> >      >>
>> >      >> Trying to do too much in the middle gets messy in my opinion,
>> >     not that
>> >      >> it seems to matter here.
>> >      >
>> >      > No problem.
>> >      >
>> >      >>>> +
>> >      >>>> +        if (total) {
>> >      >>>> +            list[total - 1] =3D '\n';
>> >      >>>> +        }
>> >      >>>> +        len =3D strlen(chs_string) + 1;
>> >      >>>> +        list =3D g_realloc(list, total + len);
>> >      >>>> +        memcpy(&list[total], chs_string, len);
>> >      >>>> +        total +=3D len;
>> >      >>>> +        g_free(chs_string);
>> >      >>>> +        g_free(bootpath);
>> >      >>>> +    }
>> >      >>>> +
>> >      >>>> +    *size =3D total;
>> >      >>>> +
>> >      >>>> +    return list;
>> >      >>>> +}
>> >      >>>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>> >      >>>> index 7dc3ac378e..18aff658c0 100644
>> >      >>>> --- a/hw/nvram/fw_cfg.c
>> >      >>>> +++ b/hw/nvram/fw_cfg.c
>> >      >>>> @@ -920,13 +920,21 @@ void *fw_cfg_modify_file(FWCfgState *s=
,
>> >     const char *filename,
>> >      >>>>
>> >      >>>>  static void fw_cfg_machine_reset(void *opaque)
>> >      >>>>  {
>> >      >>>> +    MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine=
());
>> >      >>>> +    FWCfgState *s =3D opaque;
>> >      >>>>      void *ptr;
>> >      >>>>      size_t len;
>> >      >>>> -    FWCfgState *s =3D opaque;
>> >      >>>> -    char *bootindex =3D get_boot_devices_list(&len);
>> >      >>>> +    char *buf;
>> >      >>>>
>> >      >>>> -    ptr =3D fw_cfg_modify_file(s, "bootorder", (uint8_t
>> >     *)bootindex, len);
>> >      >>>> +    buf =3D get_boot_devices_list(&len);
>> >      >>>> +    ptr =3D fw_cfg_modify_file(s, "bootorder", (uint8_t *)b=
uf,
>> >     len);
>> >      >>>>      g_free(ptr);
>> >      >>>> +
>> >      >>>> +    if (!mc->legacy_fw_cfg_order) {
>> >      >>>> +        buf =3D get_boot_devices_lchs_list(&len);
>> >      >>>> +        ptr =3D fw_cfg_modify_file(s, "bios-geometry", (uin=
t8_t
>> >     *)buf, len);
>> >      >>>
>> >      >>> OK. Can you add a test in tests/fw_cfg-test.c please?
>> >      >>>
>> >      >>
>> >      >> :D
>> >      >>
>> >      >>>> +        g_free(ptr);
>> >      >>>> +    }
>> >      >>>>  }
>> >      >>>>
>> >      >>>>  static void fw_cfg_machine_ready(struct Notifier *n, void *=
data)
>> >      >>>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu=
.h
>> >      >>>> index 5bc5c79cbc..80c57fdc4e 100644
>> >      >>>> --- a/include/sysemu/sysemu.h
>> >      >>>> +++ b/include/sysemu/sysemu.h
>> >      >>>> @@ -106,6 +106,7 @@ void validate_bootdevices(const char
>> >     *devices, Error **errp);
>> >      >>>>  void add_boot_device_lchs(DeviceState *dev, const char *suf=
fix,
>> >      >>>>                            uint32_t lcyls, uint32_t lheads,
>> >     uint32_t lsecs);
>> >      >>>>  void del_boot_device_lchs(DeviceState *dev, const char *suf=
fix);
>> >      >>>> +char *get_boot_devices_lchs_list(size_t *size);
>> >      >>>
>> >      >>> Please add some documentation. At least 'size' must be non-NU=
LL.
>> >      >>>
>> >      >>
>> >      >> Sure; but I wasn't going to gate on it because this series wen=
t
>> >     unloved
>> >      >> for so long. At this point, a follow-up patch is fine.
>> >      >
>> >      > OK
>> >      >
>> >      >>
>> >      >>> Ideally you should add doc for the other functions added in 3=
/8
>> >      >>> "bootdevice: Add interface to gather LCHS" too.
>> >      >>>
>> >      >>
>> >      >> Same thing here.
>> >      >>
>> >      >>> John, what do you think about extracting the *boot_device*
>> >     functions out
>> >      >>> of "sysemu.h"?
>> >      >>>
>> >      >>
>> >      >> Potentially worthwhile; but not critical at the moment. The
>> >     source tree
>> >      >> is not the best-organized thing as-is and I don't think it's f=
air to
>> >      >> hold this series up for much longer for nice-to-haves, ultimat=
ely.
>> >      >>
>> >      >> More targeted improvements might avoid the "whose responsibili=
ty
>> >     is it
>> >      >> to stage this?" hot potato we played with this one; so I'd
>> >     rather have
>> >      >> smaller follow-up patches handled by the respective maintainer=
s.
>> >      >
>> >      > Sure, fair enough.
>> >
>> >     I forgot:
>> >     Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>> >     <mailto:philmd@redhat.com>>
>>
>> Meanwhile I withdraw my fast R-b :(
>>
>> Regards,
>>
>> Phil.

