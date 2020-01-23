Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D504AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C09420704
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="f5cKCAKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C09420704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iudbI-0007kM-6f
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 09:36:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dme@dme.org>) id 1iubQH-00079Q-7L
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:17:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dme@dme.org>) id 1iubQF-0001Qc-1g
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:17:20 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35183)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dme@dme.org>) id 1iubQE-0001N9-1G
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:17:18 -0500
Received: by mail-wm1-x344.google.com with SMTP id p17so2320946wmb.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 04:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:subject:in-reply-to:references:from:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ghPuYZiXHTId5LdvMoeGG4ShL2m624b36Msb3cFnugA=;
 b=f5cKCAKixztcaP9ET8Q9fNtqedKFLFBjQ8XB5CwvqA9L8M6NvT/5DZsMeBKYAErurb
 2bKEnDWoXLQIUkmW7VL+vLx+0U+UrVSLV6OFcAlQntfiP8z61rtabTydtQrzuPMK7svl
 kqj37mhW8v+SlPCEMtC/d5CXPMYVd42BDRW4jNFt50E7DMCMFU4P1Xe6SgndZqB7KUhM
 yQSt9MEj6MWZsBZnwVdiMChdnr1lGlx+mugdnFnbk+dROkbpk4d4sy23pHY0ZFWasWP5
 9ENIzVcmWLKmMQhCXjdqWMqi7p+hruTexgSGX5o47y8vYfN7Ur0sghkX2yWriiVftOGI
 4pEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:subject:in-reply-to:references:from:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ghPuYZiXHTId5LdvMoeGG4ShL2m624b36Msb3cFnugA=;
 b=EoDhutUVgpmENqmlSq96f1PcR7PzNFv1jLcxsMqyEra68M1GZ+ylfPgJlFK2gUkM65
 57atD+c5AhbyLlW3r6sxq94fuF7DtpjKJyoKFRMaxLwns5lhaRZY1WOL/HmmC8ejfPGK
 tStSPe5896ohBQGqmtSV7KqiDCDEPkbB1koTOhiJDhZo0pMHWfQBLcZ+zvd9rMHT74gn
 o6LymlLRlJaF/17vqPnATnmf8B40b4nuGRHV7R/9mbCj0YSCEPQOHQ1zDsWQCcs3vR42
 0fwLE3GAaEHC7ro1GBO8DrHgPIPRWG4d48oLLyy4KUYIkROyFjIRJki3Tz3buQkHHFGp
 UuJQ==
X-Gm-Message-State: APjAAAXy+hC+z1uIVxSVKBQow8hJM85h4ALAUOANBfHaQCHyaYbmjsCt
 YFGTOSM28xH5nUJr26dytFjYNu75o4M=
X-Google-Smtp-Source: APXvYqzi7usCY+y0DSlvwSTH+8KDmEdmVlBxZcrdJedqjsibEEoDG7AkMtGiumpzFcDjGr4HAJtZYg==
X-Received: by 2002:a1c:2089:: with SMTP id g131mr3737361wmg.63.1579781831627; 
 Thu, 23 Jan 2020 04:17:11 -0800 (PST)
Received: from disaster-area.hh.sledj.net (disaster-area.hh.sledj.net.
 [81.149.164.25])
 by smtp.gmail.com with ESMTPSA id f1sm2740182wrp.93.2020.01.23.04.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 04:17:10 -0800 (PST)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id e1587faa;
 Thu, 23 Jan 2020 12:17:09 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, Qemu-block
 <qemu-block@nongnu.org>
Subject: Re: [PATCH] qemu-img: Add --target-is-zero to convert
In-Reply-To: <38073ceb-922e-b0fb-0c20-05fb4831e9a8@redhat.com>
References: <id:m21rryz8al.fsf@dme.org>
 <20200117103434.1363985-1-david.edmondson@oracle.com>
 <38073ceb-922e-b0fb-0c20-05fb4831e9a8@redhat.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
X-Playing: Four Tet: Spirit Fingers (Live In Copenhagen)
Date: Thu, 23 Jan 2020 12:17:09 +0000
Message-ID: <m2muaev03e.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

On Tuesday, 2020-01-21 at 16:02:16 +01, Max Reitz wrote:

> Hi,
>
> On 17.01.20 11:34, David Edmondson wrote:
>> In many cases the target of a convert operation is a newly provisioned
>> target that the user knows is blank (filled with zeroes). In this
>> situation there is no requirement for qemu-img to wastefully zero out
>> the entire device.
>>=20
>> Add a new option, --target-is-zero, allowing the user to indicate that
>> an existing target device is already zero filled.
>> ---
>>  qemu-img.c | 19 ++++++++++++++++---
>>  1 file changed, 16 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/qemu-img.c b/qemu-img.c
>> index 95a24b9762..56ca727e8c 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -70,6 +70,7 @@ enum {
>>      OPTION_PREALLOCATION =3D 265,
>>      OPTION_SHRINK =3D 266,
>>      OPTION_SALVAGE =3D 267,
>> +    OPTION_TARGET_IS_ZERO =3D 268,
>>  };
>>=20=20
>>  typedef enum OutputFormat {
>> @@ -1593,6 +1594,7 @@ typedef struct ImgConvertState {
>>      bool copy_range;
>>      bool salvage;
>>      bool quiet;
>> +    bool target_is_zero;
>
> As you already said, we probably don=E2=80=99t need this and it=E2=80=99d=
 be sufficient
> to set the has_zero_init value directly.
>
>>      int min_sparse;
>>      int alignment;
>>      size_t cluster_sectors;
>> @@ -1984,10 +1986,11 @@ static int convert_do_copy(ImgConvertState *s)
>>      int64_t sector_num =3D 0;
>>=20=20
>>      /* Check whether we have zero initialisation or can get it efficien=
tly */
>> -    if (s->target_is_new && s->min_sparse && !s->target_has_backing) {
>> +    s->has_zero_init =3D s->target_is_zero;
>
> We cannot has_zero_init to true if the target has a backing file,
> because convert_co_write() asserts that the target must not have a
> backing file if has_zero_init is true.  (It=E2=80=99s impossible for a fi=
le to
> be initialized to zeroes if it has a backing file; or at least it
> doesn=E2=80=99t make sense then to have a backing file.)

I'll add a check causing (has_zero_init && target_has_backing) to throw
an error after the target_has_backing is determined.

> Case in point:
>
> $ ./qemu-img create -f qcow2 src.qcow2 64M
> Formatting 'src.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D65536
> lazy_refcounts=3Doff refcount_bits=3D16
> $ ./qemu-img create -f qcow2 backing.qcow2 64M
> Formatting 'backing.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D65=
536
> lazy_refcounts=3Doff refcount_bits=3D16
> $ ./qemu-img create -f qcow2 -b backing.qcow2 dst.qcow2 64M
>
> Formatting 'dst.qcow2', fmt=3Dqcow2 size=3D67108864
> backing_file=3Dbacking.qcow2 cluster_size=3D65536 lazy_refcounts=3Doff
> refcount_bits=3D16
> $ ./qemu-img convert -n -B backing.qcow2 -f qcow2 -O qcow2
> --target-is-zero src.qcow2 dst.qcow2
> qemu-img: qemu-img.c:1812: convert_co_write: Assertion
> `!s->target_has_backing' failed.
> [1]    80813 abort (core dumped)  ./qemu-img convert -n -B backing.qcow2
> -f qcow2 -O qcow2 --target-is-zero
>
>> +
>> +    if (!s->has_zero_init && s->target_is_new && s->min_sparse &&
>> +        !s->target_has_backing) {
>
> (This will be irrelevant after target_has_backing is gone, but because
> has_zero_init and target_has_backing are equivalent here, there is no
> need to check both.)

I don't understand this comment - I must be missing something.

If both has_zero_init and target_has_backing are false here, we should
go and check bdrv_has_zero_init().

They can't both be true (when the above mentioned test is added) and if
either is true, we don't want to call brv_has_zero_init(), as either the
user has asserted that the target is blank or we have a backing file.

>>          s->has_zero_init =3D bdrv_has_zero_init(blk_bs(s->target));
>> -    } else {
>> -        s->has_zero_init =3D false;
>>      }
>>=20=20
>>      if (!s->has_zero_init && !s->target_has_backing &&
>> @@ -2076,6 +2079,7 @@ static int img_convert(int argc, char **argv)
>>          .buf_sectors        =3D IO_BUF_SIZE / BDRV_SECTOR_SIZE,
>>          .wr_in_order        =3D true,
>>          .num_coroutines     =3D 8,
>> +        .target_is_zero     =3D false,
>>      };
>>=20=20
>>      for(;;) {
>> @@ -2086,6 +2090,7 @@ static int img_convert(int argc, char **argv)
>>              {"force-share", no_argument, 0, 'U'},
>>              {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_O=
PTS},
>>              {"salvage", no_argument, 0, OPTION_SALVAGE},
>> +            {"target-is-zero", no_argument, 0, OPTION_TARGET_IS_ZERO},
>>              {0, 0, 0, 0}
>>          };
>>          c =3D getopt_long(argc, argv, ":hf:O:B:Cco:l:S:pt:T:qnm:WU",
>> @@ -2209,6 +2214,9 @@ static int img_convert(int argc, char **argv)
>>          case OPTION_TARGET_IMAGE_OPTS:
>>              tgt_image_opts =3D true;
>>              break;
>> +        case OPTION_TARGET_IS_ZERO:
>> +            s.target_is_zero =3D true;
>> +            break;
>>          }
>>      }
>>=20=20
>> @@ -2247,6 +2255,11 @@ static int img_convert(int argc, char **argv)
>>          warn_report("This will become an error in future QEMU versions.=
");
>>      }
>>=20=20
>> +    if (s.target_is_zero && !skip_create) {
>> +        error_report("--target-is-zero requires use of -n flag");
>
> Hm, I could imagine it being useful even without -n, but maybe it=E2=80=
=99s
> safer to forbid this case for now and reconsider if someone were to ask.
>
>> +        goto fail_getopt;
>> +    }
>> +
>>      s.src_num =3D argc - optind - 1;
>>      out_filename =3D s.src_num >=3D 1 ? argv[argc - 1] : NULL;
>
> This patch should also add some documentation for the new option (in
> qemu-img-cmds.hx and in qemu-img.texi for the man page).

Will do.

dme.
--=20
You can't hide from the flipside.

