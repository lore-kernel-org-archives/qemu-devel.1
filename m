Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB3DC33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 22:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BA02080D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 22:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLgLJcu7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BA02080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir8dw-00052P-UF
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 17:57:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1ir8dK-00044k-6Z
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 17:56:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1ir8dH-0004kb-QB
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 17:56:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43357
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1ir8dH-0004k2-J8
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 17:56:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578956186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=D1smYJBm6aPqnhlsnRgIGIk5BuzLJZeJTKeXVWub9M8=;
 b=CLgLJcu7775vAWgkfK+KVIHXhHf0N400rTRZRtj2HTnn7i/5A3ZzzIYfGAQzV240MmsO83
 KVpCNkHugrPem8QAz7hTEY2NTxwlx5ZrPRobTFPsfRUCktxOmw2lE6ralZpgBhEaH7t4R0
 nAayfQ1SLw0TcXnNjQeB/F9mvgkhVU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-5gedzKvANIOWTSBM-XcBKQ-1; Mon, 13 Jan 2020 17:56:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B39010054E3;
 Mon, 13 Jan 2020 22:56:23 +0000 (UTC)
Received: from [10.18.17.134] (dhcp-17-134.bos.redhat.com [10.18.17.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 457275D9E1;
 Mon, 13 Jan 2020 22:56:22 +0000 (UTC)
Subject: Re: [PATCH] scsi-disk: define props in scsi_block_disk to avoid
 memleaks
To: pannengyuan@huawei.com, pbonzini@redhat.com, fam@euphon.net
References: <20200113062030.56020-1-pannengyuan@huawei.com>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 mQINBFTKefwBEAChvwqYC6saTzawbih87LqBYq0d5A8jXYXaiFMV/EvMSDqqY4EY6whXliNO
 IYzhgrPEe7ZmPxbCSe4iMykjhwMh5byIHDoPGDU+FsQty2KXuoxto+ZdrP9gymAgmyqdk3aV
 vzzmCa3cOppcqKvA0Kqr10UeX/z4OMVV390V+DVWUvzXpda45/Sxup57pk+hyY52wxxjIqef
 rj8u5BN93s5uCVTus0oiVA6W+iXYzTvVDStMFVqnTxSxlpZoH5RGKvmoWV3uutByQyBPHW2U
 1Y6n6iEZ9MlP3hcDqlo0S8jeP03HaD4gOqCuqLceWF5+2WyHzNfylpNMFVi+Hp0H/nSDtCvQ
 ua7j+6Pt7q5rvqgHvRipkDDVsjqwasuNc3wyoHexrBeLU/iJBuDld5iLy+dHXoYMB3HmjMxj
 3K5/8XhGrDx6BDFeO3HIpi3u2z1jniB7RtyVEtdupED6lqsDj0oSz9NxaOFZrS3Jf6z/kHIf
 h42mM9Sx7+s4c07N2LieUxcfqhFTaa/voRibF4cmkBVUhOD1AKXNfhEsTvmcz9NbUchCkcvA
 T9119CrsxfVsE7bXiGvdXnzyGLXdsoosjzwacKdOrVaDmN3Uy+SHiQXo6TlkSdV0XH2PUxTM
 LsBFIO9qXO43Ai6J6iPAP/01l8fuZfpJE0/L/c25yyaND7xA3wARAQABtCpKb2huIFNub3cg
 KEpvaG4gSHVzdG9uKSA8anNub3dAcmVkaGF0LmNvbT6JAlQEEwECAD4CGwMCHgECF4AFCwkI
 BwMFFQoJCAsFFgIDAQAWIQT665cRoSz0dYEvGPKIqQZNGDVh6wUCXF392gUJC1Xq3gAKCRCI
 qQZNGDVh6558D/9pM4pu4njX5aT6uUW3vAmbWLF1jfPxiTQgSHAnm9EBMZED/fsvkzj97clo
 LN7JKmbYZNgJmR01A7flG45V4iOR/249qAfaVuD+ZzZi1R4jFzr13WS+IEdn0hYp9ITndb7R
 ezW+HGu6/rP2PnfmDnNowgJu6Dp6IUEabq8SXXwGHXZPuMIrsXJxUdKJdGnh1o2u7271yNO7
 J9PEMuMDsgjsdnaGtv7aQ9CECtXvBleAc06pLW2HU10r5wQyBMZGITemJdBhhdzGmbHAL0M6
 vKi/bafHRWqfMqOAdDkv3Jg4arl2NCG/uNateR1z5e529+UlB4XVAQT+f5T/YyI65DFTY940
 il3aZhA8u788jZEPMXmt94u7uPZbEYp7V0jt68SrTaOgO7NaXsboXFjwEa42Ug5lB5d5/Qdp
 1AITUv0NJ51kKwhHL1dEagGeloIsGVQILmpS0MLdtitBHqZLsnJkRvtMaxo47giyBlv2ewmq
 tIGTlVLxHx9xkc9aVepOuiGlZaZB72c9AvZs9rKaAjgU2UfJHlB/Hr4uSk/1EY0IgMv4vnsG
 1sA5gvS7A4T4euu0PqHtn2sZEWDrk5RDbw0yIb53JYdXboLFmFXKzVASfKh2ZVeXRBlQQSJi
 3PBR1GzzqORlfryby7mkY857xzCI2NkIkD2eq+HhzFTfFOTdGrkCDQRUynn8ARAAwbhP45BE
 d/zAMBPV2dk2WwIwKRSKULElP3kXpcuiDWYQob3UODUUqClO+3aXVRndaNmZX9WbzGYexVo3
 5j+CVBCGr3DlU8AL9pp3KQ3SJihWcDed1LSmUf8tS+10d6mdGxDqgnd/OWU214isvhgWZtZG
 MM/Xj7cx5pERIiP+jqu7PT1cibcfcEKhPjYdyV1QnLtKNGrTg/UMKaL+qkWBUI/8uBoa0HLs
 NH63bXsRtNAG8w6qG7iiueYZUIXKc4IHINUguqYQJVdSe+u8b2N5XNhDSEUhdlqFYraJvX6d
 TjxMTW5lzVG2KjztfErRNSUmu2gezbw1/CV0ztniOKDA7mkQi6UIUDRh4LxRm5mflfKiCyDQ
 L6P/jxHBxFv+sIgjuLrfNhIC1p3z9rvCh+idAVJgtHtYl8p6GAVrF+4xQV2zZH45tgmHo2+S
 JsLPjXZtWVsWANpepXnesyabWtNAV4qQB7/SfC77zZwsVX0OOY2Qc+iohmXo8U7DgXVDgl/R
 /5Qgfnlv0/3rOdMt6ZPy5LJr8D9LJmcP0RvX98jyoBOf06Q9QtEwJsNLCOCo2LKNL71DNjZr
 nXEwjUH66CXiRXDbDKprt71BiSTitkFhGGU88XCtrp8R9yArXPf4MN+wNYBjfT7K29gWTzxt
 9DYQIvEf69oZD5Z5qHYGp031E90AEQEAAYkCPAQYAQIAJgIbDBYhBPrrlxGhLPR1gS8Y8oip
 Bk0YNWHrBQJcXf3JBQkLVerNAAoJEIipBk0YNWHrU1AP/1FOK2SBGbyhHa5vDHuf47fgLipC
 e0/h1E0vdSonzlhPxuZoQ47FjzG9uOhqqQG6/PqtWs/FJIyz8aGG4aV+pSA/9Ko3/2ND8MSY
 ZflWs7Y8Peg08Ro01GTHFITjEUgHpTpHiT6TNcZB5aZNJ8jqCtW5UlqvXXbVeSTmO70ZiVtc
 vUJbpvSxYmzhFfZWaXIPcNcKWL1rnmnzs67lDhMLdkYVf91aml/XtyMUlfB8Iaejzud9Ht3r
 C0pA9MG57pLblX7okEshxAC0+tUdY2vANWFeX0mgqRt1GSuG9XM9H/cKP1czfUV/FgaWo/Ya
 fM4eMhUAlL/y+/AJxxumPhBXftM4yuiktp2JMezoIMJI9fmhjfWDw7+2jVrx9ze1joLakFD1
 rVAoHxVJ7ORfQ4Ni/qWbQm3T6qQkSMt4N/scNsMczibdTPxU7qtwQwIeFOOc3wEwmJ9Qe3ox
 TODQ0agXiWVj0OXYCHJ6MxTDswtyTGQW+nUHpKBgHGwUaR6d1kr/LK9+5LpOfRlK9VRfEu7D
 PGNiRkr8Abp8jHsrBqQWfUS1bAf62bq6XUel0kUCtb7qCq024aOczXYWPFpJFX+nhp4d7NeH
 Edq+wlC13sBSiSHC7T5yssJ+7JPa2ATLlSKhEvBsLe2TsSTTtFlA0nBclqhfJXzimiuge9qU
 E40lvMWBuQINBFTKimUBEADDbJ+pQ5M4QBMWkaWImRj7c598xIZ37oKM6rGaSnuB1SVb7YCr
 Ci2MTwQcrQscA2jm80O8VFqWk+/XsEp62dty47GVwSfdGje/3zv3VTH2KhOCKOq3oPP5ZXWY
 rz2d2WnTvx++o6lU7HLHDEC3NGLYNLkL1lyVxLhnhvcMxkf1EGA1DboEcMgnJrNB1pGP27ww
 cSfvdyPGseV+qZZa8kuViDga1oxmnYDxFKMGLxrClqHrRt8geQL1Wj5KFM5hFtGTK4da5lPn
 wGNd6/CINMeCT2AWZY5ySz7/tSZe5F22vPvVZGoPgQicYWdNc3ap7+7IKP86JNjmec/9RJcz
 jvrYjJdiqBVldXou72CtDydKVLVSKv8c2wBDJghYZitfYIaL8cTvQfUHRYTfo0n5KKSec8Vo
 vjDuxmdbOUBA+SkRxqmneP5OxGoZ92VusrwWCjry8HRsNdR+2T+ClDCO6Wpihu4V3CPkQwTy
 eCuMHPAT0ka5paTwLrnZIxsdfnjUa96T10vzmQgAxpbbiaLvgKJ8+76OPdDnhddyxd2ldYfw
 RkF5PEGg3mqZnYKNNBtwjvX49SAvgETQvLzQ8IKVgZS0m4z9qHHvtc1BsQnFfe+LJOFjzZr7
 CrDNJMqk1JTHYsSi2JcN3vY32WMezXSQ0TzeMK4kdnclSQyp/h23GWod5QARAQABiQRbBBgB
 AgAmAhsCFiEE+uuXEaEs9HWBLxjyiKkGTRg1YesFAlxd/coFCQtV2mQCKcFdIAQZAQIABgUC
 VMqKZQAKCRB974EGqvw5DiJoEACLmuiRq9ifvOh5DyBFwRS7gvA14DsGQngmC57EzV0EFcfM
 XVi1jX5OtwUyUe0Az5r6lHyyHDsDsIpLKBlWrYCeLpUhRR3oy181T7UNxvujGFeTkzvLAOo6
 Hs3b8Wv9ARg+7acRYkQRNY7k0GIJ6YZz149tRyRKAy/vSjsaB9Lt0NOd1wf2EQMKwRVELwJD
 y0AazGn+0PRP7Bua2YbtxaBmhBBDb2tPpwn8U9xdckB4Vlft9lcWNsC/18Gi9bpjd9FSbdH/
 sOUI+3ToWYENeoT4IP09wn6EkgWaJS3nAUN/MOycNej2i4Yhy2wDDSKyTAnVkSSSoXk+tK91
 HfqtokbDanB8daP+K5LgoiWHzjfWzsxA2jKisI4YCGjrYQzTyGOT6P6u6SEeoEx10865B/zc
 8/vN50kncdjYz2naacIDEKQNZlnGLsGkpCbfmfdi3Zg4vuWKNdWr0wGUzDUcpqW0y/lUXna+
 6uyQShX5e4JD2UPuf9WAQ9HtgSAkaDd4O1I2J41sleePzZOVB3DmYgy+ECRJJ5nw3ihdxpgc
 y/v3lfcJaqiyCv0PF+K/gSOvwhH7CbVqARmptT7yhhxqFdaYWo2Z2ksuKyoKSRMFCXQY5oac
 uTmyPIT4STFyUQFeqSCWDum/NFNoSKhmItw2Td+4VSJHShRVbg39KNFPZ7mXYAkQiKkGTRg1
 YesWJA/+PV3qDUtPNEGwjVvjQqHSbrBy94tu6gJvPHgGPtRDYvxnCaJsmgiC0pGB2KFRsnfl
 2zBNBEWF/XwsI081jQE5UO60GKmHTputChLXpVobyuc+lroG2YhknXRBAV969SLnZR4BS/1s
 Gi046gOXfaKYatve8BiZr5it5Foq3FMPDNgZMit1H9Dk8rkKFfDMRf8EGS/Z+TmyEsIf99H7
 TH3n7lco8qO81fSFwkh4pvo2kWRFYTC5vsIVQ+GqVUp+W1DZJHxX8LwWuF1AzUt4MUTtNAvy
 TXl5EgsmoY9mpNNL7ZnW65oG63nEP5KNiybvuQJzXVxR8eqzOh2Mod4nHg3PE7UCd3DvLNsn
 GXFRo44WyT/G2lArBtjpkut7bDm0i1nENABy2UgS+1QvdmgNu6aEZxdNthwRjUhuuvCCDMA4
 rCDQYyakH2tJNQgkXkeLodBKF4bHiBbuwj0E39S9wmGgg+q4OTnAO/yhQGknle7a7G5xHBwE
 i0HjnLoJP5jDcoMTabZTIazXmJz3pKM11HYJ5/ZsTIf3ZRJJKIvXJpbmcAPVwTZII6XxiJdh
 RSSX4Mvd5pL/+5WI6NTdW6DMfigTtdd85fe6PwBNVJL2ZvBfsBJZ5rxg1TOH3KLsYBqBTgW2
 glQofxhkJhDEcvjLhe3Y2BlbCWKOmvM8XS9TRt0OwUs=
Message-ID: <9292c330-0ab5-9a96-4e1b-2cb9ccc4cc33@redhat.com>
Date: Mon, 13 Jan 2020 17:56:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200113062030.56020-1-pannengyuan@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 5gedzKvANIOWTSBM-XcBKQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 Qemu-block <qemu-block@nongnu.org>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CC qemu-block

On 1/13/20 1:20 AM, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
> 
> scsi_block_realize() use scsi_realize() to init some props, but
> these props is not defined in scsi_block_disk_properties, so they will
> not be freed.
> 
> This patch defines these prop in scsi_block_disk_properties and aslo
> calls scsi_unrealize to avoid memleaks, the leak stack as
> follow(it's easy to reproduce by attaching/detaching scsi-block-disks):
> 
> =================================================================
> ==qemu-system-x86_64==32195==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 57 byte(s) in 3 object(s) allocated from:
>   #0 0x7f19f8bed768 (/lib64/libasan.so.5+0xef768)  ??:?
>   #1 0x7f19f64d9445 (/lib64/libglib-2.0.so.0+0x52445)  ??:?
>   #2 0x7f19f64f2d92 (/lib64/libglib-2.0.so.0+0x6bd92)  ??:?
>   #3 0x55975366e596 (qemu-system-x86_64+0x35c0596)  /mnt/sdb/qemu/hw/scsi/scsi-disk.c:2399
>   #4 0x559753671201 (emu-system-x86_64+0x35c3201)  /mnt/sdb/qemu/hw/scsi/scsi-disk.c:2681
>   #5 0x559753687e3e (qemu-system-x86_64+0x35d9e3e)  /mnt/sdb/qemu/hw/scsi/scsi-bus.c:58
>   #6 0x55975368ac44 (qemu-system-x86_64+0x35dcc44)  /mnt/sdb/qemu/hw/scsi/scsi-bus.c:216
>   #7 0x5597532a7840 (qemu-system-x86_64+0x31f9840)  /mnt/sdb/qemu/hw/core/qdev.c:876
> 
> Direct leak of 15 byte(s) in 3 object(s) allocated from:
>   #0 0x7f19f8bed768 (/lib64/libasan.so.5+0xef768)  ??:?
>   #1 0x7f19f64d9445 (/lib64/libglib-2.0.so.0+0x52445)  ??:?
>   #2 0x7f19f64f2d92 (/lib64/libglib-2.0.so.0+0x6bd92)  ??:?
>   #3 0x55975366e06f (qemu-system-x86_64+0x35c006f)  /mnt/sdb/qemu/hw/scsi/scsi-disk.c:2388
>   #4 0x559753671201 (qemu-system-x86_64+0x35c3201)  /mnt/sdb/qemu/hw/scsi/scsi-disk.c:2681
>   #5 0x559753687e3e (qemu-system-x86_64+0x35d9e3e)  /mnt/sdb/qemu/hw/scsi/scsi-bus.c:58
>   #6 0x55975368ac44 (qemu-system-x86_64+0x35dcc44)  /mnt/sdb/qemu/hw/scsi/scsi-bus.c:216
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>  hw/scsi/scsi-disk.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index e44c61eeb4..caec99ae20 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -2981,7 +2981,6 @@ static const TypeInfo scsi_disk_base_info = {
>  };
>  
>  #define DEFINE_SCSI_DISK_PROPERTIES()                                   \
> -    DEFINE_PROP_DRIVE_IOTHREAD("drive", SCSIDiskState, qdev.conf.blk),  \
>      DEFINE_BLOCK_PROPERTIES_BASE(SCSIDiskState, qdev.conf),             \
>      DEFINE_BLOCK_ERROR_PROPERTIES(SCSIDiskState, qdev.conf),            \
>      DEFINE_PROP_STRING("ver", SCSIDiskState, version),                  \
> @@ -2993,6 +2992,7 @@ static const TypeInfo scsi_disk_base_info = {
>  
>  static Property scsi_hd_properties[] = {
>      DEFINE_SCSI_DISK_PROPERTIES(),
> +    DEFINE_PROP_DRIVE_IOTHREAD("drive", SCSIDiskState, qdev.conf.blk),
>      DEFINE_PROP_BIT("removable", SCSIDiskState, features,
>                      SCSI_DISK_F_REMOVABLE, false),
>      DEFINE_PROP_BIT("dpofua", SCSIDiskState, features,
> @@ -3048,6 +3048,7 @@ static const TypeInfo scsi_hd_info = {
>  

Does changing around the property order here break migration?

>  static Property scsi_cd_properties[] = {
>      DEFINE_SCSI_DISK_PROPERTIES(),
> +    DEFINE_PROP_DRIVE_IOTHREAD("drive", SCSIDiskState, qdev.conf.blk),
>      DEFINE_PROP_UINT64("wwn", SCSIDiskState, qdev.wwn, 0),
>      DEFINE_PROP_UINT64("port_wwn", SCSIDiskState, qdev.port_wwn, 0),
>      DEFINE_PROP_UINT16("port_index", SCSIDiskState, port_index, 0),
> @@ -3079,9 +3080,8 @@ static const TypeInfo scsi_cd_info = {
>  
>  #ifdef __linux__
>  static Property scsi_block_properties[] = {
> -    DEFINE_BLOCK_ERROR_PROPERTIES(SCSIDiskState, qdev.conf),         \
> +    DEFINE_SCSI_DISK_PROPERTIES(),
>      DEFINE_PROP_DRIVE("drive", SCSIDiskState, qdev.conf.blk),
> -    DEFINE_PROP_BOOL("share-rw", SCSIDiskState, qdev.conf.share_rw, false),
>      DEFINE_PROP_UINT16("rotation_rate", SCSIDiskState, rotation_rate, 0),
>      DEFINE_PROP_UINT64("max_unmap_size", SCSIDiskState, max_unmap_size,
>                         DEFAULT_MAX_UNMAP_SIZE),
> @@ -3099,6 +3099,7 @@ static void scsi_block_class_initfn(ObjectClass *klass, void *data)
>      SCSIDiskClass *sdc = SCSI_DISK_BASE_CLASS(klass);
>  
>      sc->realize      = scsi_block_realize;
> +    sc->unrealize    = scsi_unrealize;
>      sc->alloc_req    = scsi_block_new_request;
>      sc->parse_cdb    = scsi_block_parse_cdb;
>      sdc->dma_readv   = scsi_block_dma_readv;
> @@ -3119,6 +3120,7 @@ static const TypeInfo scsi_block_info = {
>  
>  static Property scsi_disk_properties[] = {
>      DEFINE_SCSI_DISK_PROPERTIES(),
> +    DEFINE_PROP_DRIVE_IOTHREAD("drive", SCSIDiskState, qdev.conf.blk),
>      DEFINE_PROP_BIT("removable", SCSIDiskState, features,
>                      SCSI_DISK_F_REMOVABLE, false),
>      DEFINE_PROP_BIT("dpofua", SCSIDiskState, features,
> 


