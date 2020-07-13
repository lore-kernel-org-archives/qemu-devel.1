Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9FAC433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A66206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHHI0r38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A66206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juvh3-00085j-LE
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 06:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1juvg1-00078c-Dm
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:27:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54967
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1juvfy-0007Zd-UF
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594636029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ncPtTJPKX1xmM0tVAUOJc+GII682XePoWciV2TEULjo=;
 b=UHHI0r38x85aWYQhCRFi5yhDEMPq3PslFygjZfFso1ClSSqij/nhqGcUBDhjkARSjr9lXc
 O5B8I0I7iiyL21W8LHjcagI8oULxa2T7dh6Vpoq2z/RtgfqtEQ6pw7qGutMHw35IXyYWP5
 nRh4wInFPxYqk0gRHJNJQt6DhZC90FQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373--FcwuHfNO8mhvQZ7lYUMPA-1; Mon, 13 Jul 2020 06:27:05 -0400
X-MC-Unique: -FcwuHfNO8mhvQZ7lYUMPA-1
Received: by mail-ed1-f70.google.com with SMTP id dg19so20350596edb.6
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 03:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=9d7rBoTyE4r5RdzW8QwtqD84Ju8Dacpcjd3wKcSejq8=;
 b=Fpd0VxrfqfZaH/QxAZRmBwH+mcaKRuBPfD95wnA+DpuZWMHBwvkHJ2wQoglDNr+SYP
 2F3eyKPFBeFfO4ciNU7fnyMSXkwZ2Xhk4PBr0ajjooA1O95dxxUx/uJk1bQscLQvNoE3
 /0jD+fwWxJTkLKj3ykOpRHgKO0E0hGVQAQRZueD204t+SO8QK/6ziauXMgiOlFTK/+CV
 yfVmdiAAb/8aRrmOG4U/MifXTUk5iwXVdJMmiNoG/OEcYUtaMBFxXTVbLHD5GAec4lig
 HjzK/L73xC0y+0CAVtqcuhQgCz2wc2AAFDQqUv6qHdp8EYTYr0ocC0uvSrIsrrtFRqb4
 fuGQ==
X-Gm-Message-State: AOAM532cIT9Im9fmMUBmHqE7hvvgL0hp2ZIr9fKkBMKA3Obxy+/AXw46
 QIGCoMHJ/gBQ3BTAP+wkt34udUZR9W+25aitLNhqNkv0+dFHG5AHDy7gAhhlts24VZ/75G8R49Y
 tB54lcchi9Jm6iqE=
X-Received: by 2002:aa7:db4b:: with SMTP id n11mr2230314edt.137.1594636024132; 
 Mon, 13 Jul 2020 03:27:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnYskRbwMwHdhZWBCN9R+D/aIs+YHht39XZozaEgSU4Yvmg5oQMVdO16owYN7mXj/dH0gPCg==
X-Received: by 2002:aa7:db4b:: with SMTP id n11mr2230298edt.137.1594636023908; 
 Mon, 13 Jul 2020 03:27:03 -0700 (PDT)
Received: from ?IPv6:2a01:598:b902:a219:9d3c:1f9c:371:6e61?
 ([2a01:598:b902:a219:9d3c:1f9c:371:6e61])
 by smtp.gmail.com with ESMTPSA id ay27sm11276609edb.81.2020.07.13.03.27.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 03:27:03 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC 2/5] s390x: implement diag260
Date: Mon, 13 Jul 2020 12:27:01 +0200
Message-Id: <07E9FD5B-F07F-415B-9C00-A2A882F07CBC@redhat.com>
References: <20200713091243.GB4359@osiris>
In-Reply-To: <20200713091243.GB4359@osiris>
To: Heiko Carstens <hca@linux.ibm.com>
X-Mailer: iPhone Mail (17F80)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Am 13.07.2020 um 11:12 schrieb Heiko Carstens <hca@linux.ibm.com>:
>=20
> =EF=BB=BFOn Fri, Jul 10, 2020 at 05:24:07PM +0200, David Hildenbrand wrot=
e:
>>> On 10.07.20 17:18, Heiko Carstens wrote:
>>> On Fri, Jul 10, 2020 at 02:12:33PM +0200, David Hildenbrand wrote:
>>>>> Note: Reading about diag260 subcode 0xc, we could modify Linux to que=
ry
>>>>> the maximum possible pfn via diag260 0xc. Then, we maybe could avoid
>>>>> indicating maxram size via SCLP, and keep diag260-unaware OSs keep
>>>>> working as before. Thoughts?
>>>>=20
>>>> Implemented it, seems to work fine.
>>>=20
>>> The returned value would not include standby/reserved memory within
>>> z/VM. So this seems not to work.
>>=20
>> Which value exactly are you referencing? diag 0xc returns two values.
>> One of them seems to do exactly what we need.
>>=20
>> See
>> https://github.com/davidhildenbrand/linux/commit/a235f9fb20df7c04ae89bc0=
d134332d1a01842c7
>>=20
>> for my current Linux approach.
>>=20
>>> Also: why do you want to change this
>>=20
>> Which change exactly do you mean?
>>=20
>> If we limit the value returned via SCLP to initial memory, we cannot
>> break any guest (e.g., Linux pre 4.2, kvm-unit-tests). diag260 is then
>> purely optional.
>=20
> Ok, now I see the context. Christian added my just to cc on this
> specific patch.

I tried to Cc you an all patches but the mail bounced with unknown address =
(maybe I messed up).

> So if I understand you correctly, then you want to use diag 260 in
> order to figure out how much memory is _potentially_ available for a
> guest?

Yes, exactly.

>=20
> This does not fit to the current semantics, since diag 260 returns the
> address of the highest *currently* accessible address. That is: it
> does explicitly *not* include standby memory or anything else that
> might potentially be there.

The confusing part is that it talks about =E2=80=9Eadressible=E2=80=9C and =
not =E2=80=9Eaccessible=E2=80=9C. Now that I understood the =E2=80=9EDEFINE=
 STORAGE ...=E2=80=9C example, it makes sense that the values change with r=
eserved/standby memory.

I agree that reusing that interface might not be what we want. I just seeme=
d too easy to avoid creating something new :)

>=20
> So you would need a different interface to tell the guest about your
> new hotplug memory interface. If sclp does not work, then maybe a new
> diagnose(?).
>=20

Yes, I think a new Diagnose makes sense. I=E2=80=98ll have a look next week=
 to figure out which codes/subcodes we could use. @Christian @Conny any ide=
as/pointers?


