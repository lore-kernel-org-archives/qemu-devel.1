Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E8CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1A0208E4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="o3lKcn2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1A0208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrLPo-0007w6-KZ
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jrLPE-0007QW-T3; Fri, 03 Jul 2020 09:07:04 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:54033)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jrLPB-0006DU-5m; Fri, 03 Jul 2020 09:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=Q5F2RGlY7GUZ1Aqrq6hsVGl+3Ta+Jdogdakkoj9zcng=; 
 b=o3lKcn2MLVn+A0DAyiiHG7cZmO6b3792AvR2TlGWF0/wE8lxfHowAFwQ2f0Vq6VFWAqgVfOnZeLYrjifA5sOvWO6gCnXw/PbUBIbWxoTzzkq+mZ7av42gytPjER8S5RL1pZpUDQbn6gOQZvqy35AHW5sUvAXLpsKBue7BEmSPnw84cR4YJ6LAm6ejgRKXxanXloHANHA6YBAklrWQmMb8kO4z+TQ2pwdA7owQRjdqZf+4Oj7sRWsDGa9IkslkPQGC1ShYvlsVlAoWfpaPepnBQgYtYl+/rQ+v2O1b5omhmOdUbPGLovMC4K9PL8azf2yMWM3m/kfYyPtRzOpc+xh2w==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jrLP6-000881-Tw; Fri, 03 Jul 2020 15:06:56 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jrLP6-0002wf-JS; Fri, 03 Jul 2020 15:06:56 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 34/34] iotests: Add tests for qcow2 images with
 extended L2 entries
In-Reply-To: <2a791051-5967-0279-75a1-4a44817b83b3@redhat.com>
References: <cover.1593342067.git.berto@igalia.com>
 <536717bef174a2d5405647bf9ecf899e0aafadbb.1593342067.git.berto@igalia.com>
 <2a791051-5967-0279-75a1-4a44817b83b3@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 03 Jul 2020 15:06:56 +0200
Message-ID: <w51o8owwxvz.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 08:43:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 03 Jul 2020 11:49:14 AM CEST, Max Reitz wrote:
>> +_supported_fmt qcow2
>> +_supported_proto file nfs
>> +_supported_os Linux
>> +_unsupported_imgopts extended_l2 compat=3D0.10 cluster_size data_file
>
> I=E2=80=99d also add a 'refcount_bits=3D1[^0-9]', because this test doesn=
=E2=80=99t pass
> with refcount-bits=3D1 (due to taking a snapshot at one point).

Ok

>> +    expected_bitmap=3D0
>> +    for bit in $expected_alloc; do
>> +        expected_bitmap=3D$(($expected_bitmap | (1 << $bit)))
>> +    done
>> +    for bit in $expected_zero; do
>> +        expected_bitmap=3D$(($expected_bitmap | (1 << (32 + $bit))))
>> +    done
>> +    printf -v expected_bitmap "%llu" $expected_bitmap # Convert to unsi=
gned
>
> Does the length modifier =E2=80=9Cll=E2=80=9D actually do anything?
>
>> +
>> +    printf "L2 entry #%d: 0x%016lx %016lx\n" "$entry_no" "$entry" "$bit=
map"
>
> Or the =E2=80=9Cl=E2=80=9D here?

Actually they don't (I just tested in i386 and x86_64), I assumed that
it would require the length modifiers like in C.

I'm tempted to leave them for clarity (using 'll' in both cases),
opinions?

Berto

