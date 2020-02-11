Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15ABFC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 08:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA964206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 08:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VH2ePv/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA964206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1QYE-00049Z-RM
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 03:05:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1QWe-0002QB-6u
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:04:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1QWb-0004NL-6m
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:04:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47924
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1QWb-0004Mw-0e
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581408244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FBZdfJmCXb0hiXkGwgxFG3Ce1f59q1ScWRoHHsAPhXY=;
 b=VH2ePv/E31/NjPdGn4td713oxse2annSKx2uBLb49M+ywUHlOe2yhBgT4Bw8kUETol08sV
 oUlJV5ZMDeeVPlNr53GWK1fgbfj+TrP2BUlaPsAbfeWRp9Nyjj3C+1ZtbIBg+7jebXo5aj
 /nD2FLG7UK3KSqJXwTsLlk6eYGQfkow=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-u7EYxWfXOZSSa9EprC6Y4g-1; Tue, 11 Feb 2020 03:04:02 -0500
Received: by mail-wr1-f69.google.com with SMTP id t6so6501623wru.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 00:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iIA/w9hvufxfIgsQxt22ce+F65/lAMhjPGBf9KcVph4=;
 b=Jcfo4Arf7Se68pvWvG3ut+6fXT2iFfWrJQQJWgjy5eCRUxU+fJVK1nnYJCQG2/0d1P
 QcKZJ78NWNm/jBM0wFqVDVV12mFEt4wZwbf0hRBWZFpMx1rBeyij8wOeUDKj56bsOAxv
 hmM7SgvKM52iVoYr3fC9NC2GsVWd9uCTGXpGsOMJkF83BMIiSlWNXvRSrWnOxm0dfWer
 RkiY7P/CfUguaZNaS4/EJHQcnIt3Eq8bGRCgPkNf24ooMNKN1l+wFOaSB1QAEAKTwZ5o
 aGxFUxRELRdhxB4ob+IMg4DRm5QIWYkExJLkq2cu4H5VliVhmRqb9pGUNsFXPJV4ELac
 MJGg==
X-Gm-Message-State: APjAAAX7oUKtr0g/XlI3lGn0i/os5FXAFoWGD7SDK0nXcQW/F0d0dDo3
 YOc3BV8QuIXfjm4Gj2qMiYYhTIVk81z++7NdzbPw3WkZqcuTxbPXzE1tXJglTGcr+9mR5Sz0vi8
 EloauL9F0/UGdQng=
X-Received: by 2002:a5d:4a48:: with SMTP id v8mr7036211wrs.42.1581408240947;
 Tue, 11 Feb 2020 00:04:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqy5VgXDm8m35LTOIkZ3Z0Kdv8zhaiKuq6eB7gpb3iqnla2hVjQwM3MgDzqCm9lWrzz5wCEA9g==
X-Received: by 2002:a5d:4a48:: with SMTP id v8mr7036177wrs.42.1581408240596;
 Tue, 11 Feb 2020 00:04:00 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id s12sm4180249wrw.20.2020.02.11.00.03.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 00:04:00 -0800 (PST)
Subject: Re: [RFC PATCH 28/66] Hexagon generater phase 4 - Decode tree
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
 <1581381644-13678-29-git-send-email-tsimpson@quicinc.com>
 <8de75140-9592-7740-12e7-da1ed1d0ee27@redhat.com>
Message-ID: <94290204-5281-39a0-73de-d0d2021452a2@redhat.com>
Date: Tue, 11 Feb 2020 09:03:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8de75140-9592-7740-12e7-da1ed1d0ee27@redhat.com>
Content-Language: en-US
X-MC-Unique: u7EYxWfXOZSSa9EprC6Y4g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 8:37 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/11/20 1:40 AM, Taylor Simpson wrote:
>> Python script that emits the decode tree in dectree_generated.h.
>>
>> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
>> ---
>> =C2=A0 target/hexagon/dectree.py | 354=20
>> ++++++++++++++++++++++++++++++++++++++++++++++
>> =C2=A0 1 file changed, 354 insertions(+)
>> =C2=A0 create mode 100755 target/hexagon/dectree.py
>>
>> diff --git a/target/hexagon/dectree.py b/target/hexagon/dectree.py
>> new file mode 100755
>> index 0000000..a0435c9
>> --- /dev/null
>> +++ b/target/hexagon/dectree.py
>> @@ -0,0 +1,354 @@
>> +#!/usr/bin/env python
>=20
> python3
>=20
>> +
>> +from __future__ import print_function
>=20
> Not needed anymore.
>=20
>> +##
>> +##=C2=A0 Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights=
=20
>> Reserved.
>> +##
>> +##=C2=A0 This program is free software; you can redistribute it and/or =
modify
>> +##=C2=A0 it under the terms of the GNU General Public License as publis=
hed by
>> +##=C2=A0 the Free Software Foundation; either version 2 of the License,=
 or
>> +##=C2=A0 (at your option) any later version.
>> +##
>> +##=C2=A0 This program is distributed in the hope that it will be useful=
,
>> +##=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +##=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See=
 the
>> +##=C2=A0 GNU General Public License for more details.
>> +##
>> +##=C2=A0 You should have received a copy of the GNU General Public Lice=
nse
>> +##=C2=A0 along with this program; if not, see <http://www.gnu.org/licen=
ses/>.
>> +##
>> +
>> +import cStringIO

Another Python 3 failure:

   GEN     Hexagon decode tree
Traceback (most recent call last):
   File "target/hexagon/dectree.py", line 20, in <module>
     import cStringIO
ModuleNotFoundError: No module named 'cStringIO'

>> +import re
>> +
>> +import sys
>> +sys.path.insert(0, sys.argv[1])
>> +import iset
>> +
>> +encs =3D {tag : ''.join(reversed(iset.iset[tag]['enc'].replace(' ', '')=
))
>> +=C2=A0=C2=A0=C2=A0 for tag in iset.tags if iset.iset[tag]['enc'] !=3D '=
MISSING ENCODING'}
>> +
>> +enc_classes =3D set([iset.iset[tag]['enc_class'] for tag in encs.keys()=
])
>> +subinsn_enc_classes =3D \
>> +=C2=A0=C2=A0=C2=A0 set([enc_class for enc_class in enc_classes \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if enc_class.startswith('SUB=
INSN_')])
>> +ext_enc_classes =3D \
>> +=C2=A0=C2=A0=C2=A0 set([enc_class for enc_class in enc_classes \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if enc_class not in ('NORMAL=
', '16BIT') and \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 not enc_cl=
ass.startswith('SUBINSN_')])
>> +
>> +try:
>> +=C2=A0=C2=A0=C2=A0 subinsn_groupings =3D iset.subinsn_groupings
>> +except AttributeError:
>> +=C2=A0=C2=A0=C2=A0 subinsn_groupings =3D {}
>> +
>> +for (tag, subinsn_grouping) in subinsn_groupings.items():
>> +=C2=A0=C2=A0=C2=A0 encs[tag] =3D ''.join(reversed(subinsn_grouping['enc=
'].replace(' ',=20
>> '')))
>> +
>> +dectree_normal =3D {'leaves' : set()}
>> +dectree_16bit =3D {'leaves' : set()}
>> +dectree_subinsn_groupings =3D {'leaves' : set()}
>> +dectree_subinsns =3D {name : {'leaves' : set()} for name in=20
>> subinsn_enc_classes}
>> +dectree_extensions =3D {name : {'leaves' : set()} for name in=20
>> ext_enc_classes}
>> +
>> +for tag in encs.keys():
>> +=C2=A0=C2=A0=C2=A0 if tag in subinsn_groupings:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dectree_subinsn_groupings['l=
eaves'].add(tag)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue
>> +=C2=A0=C2=A0=C2=A0 enc_class =3D iset.iset[tag]['enc_class']
>> +=C2=A0=C2=A0=C2=A0 if enc_class.startswith('SUBINSN_'):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if len(encs[tag]) !=3D 32:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 encs=
[tag] =3D encs[tag] + '0' * (32 - len(encs[tag]))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dectree_subinsns[enc_class][=
'leaves'].add(tag)
>> +=C2=A0=C2=A0=C2=A0 elif=C2=A0 enc_class =3D=3D '16BIT':
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if len(encs[tag]) !=3D 16:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rais=
e Exception('Tag "{}" has enc_class "{}" and not an=20
>> encoding ' +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 'width of 16 bits!'.format(tag, enc_class))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dectree_16bit['leaves'].add(=
tag)
>> +=C2=A0=C2=A0=C2=A0 else:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if len(encs[tag]) !=3D 32:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rais=
e Exception('Tag "{}" has enc_class "{}" and not an=20
>> encoding ' +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 'width of 32 bits!'.format(tag, enc_class))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if enc_class =3D=3D 'NORMAL'=
:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dect=
ree_normal['leaves'].add(tag)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dect=
ree_extensions[enc_class]['leaves'].add(tag)
>> +
>> +faketags =3D set()
>> +for (tag, enc) in iset.enc_ext_spaces.items():
>> +=C2=A0=C2=A0=C2=A0 faketags.add(tag)
>> +=C2=A0=C2=A0=C2=A0 encs[tag] =3D ''.join(reversed(enc.replace(' ', ''))=
)
>> +=C2=A0=C2=A0=C2=A0 dectree_normal['leaves'].add(tag)
>> +
>> +faketags |=3D set(subinsn_groupings.keys())
>> +
>> +def every_bit_counts(bitset):
>> +=C2=A0=C2=A0=C2=A0 for i in range(1, len(next(iter(bitset)))):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if len(set([bits[:i] + bits[=
i+1:] for bits in bitset])) =3D=3D=20
>> len(bitset):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn False
>> +=C2=A0=C2=A0=C2=A0 return True
>> +
>> +def auto_separate(node):
>> +=C2=A0=C2=A0=C2=A0 tags =3D node['leaves']
>> +=C2=A0=C2=A0=C2=A0 if len(tags) <=3D 1:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return
>> +=C2=A0=C2=A0=C2=A0 enc_width =3D len(encs[next(iter(tags))])
>> +=C2=A0=C2=A0=C2=A0 opcode_bit_for_all =3D \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [all([encs[tag][i] in '01' \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for =
tag in tags]) for i in range(enc_width)]
>> +=C2=A0=C2=A0=C2=A0 opcode_bit_is_0_for_all =3D \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [opcode_bit_for_all[i] and a=
ll([encs[tag][i] =3D=3D '0' \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for =
tag in tags]) for i in range(enc_width)]
>> +=C2=A0=C2=A0=C2=A0 opcode_bit_is_1_for_all =3D \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [opcode_bit_for_all[i] and a=
ll([encs[tag][i] =3D=3D '1' \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for =
tag in tags]) for i in range(enc_width)]
>> +=C2=A0=C2=A0=C2=A0 differentiator_opcode_bit =3D \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [opcode_bit_for_all[i] and \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 not (opcode_bit_is_0_f=
or_all[i] or \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opcode_bit_is_1_for_al=
l[i]) \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for =
i in range(enc_width)]
>> +=C2=A0=C2=A0=C2=A0 best_width =3D 0
>> +=C2=A0=C2=A0=C2=A0 for width in range(4, 0, -1):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for lsb in range(enc_width -=
 width, -1, -1):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bits=
et =3D set([encs[tag][lsb:lsb+width] for tag in tags])
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if a=
ll(differentiator_opcode_bit[lsb:lsb+width]) and \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (len(bitset) =3D=3D len(tags) or every_bit_counts(bit=
set)):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 best_width =3D width
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 best_lsb =3D lsb
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 caught_all_tags =3D len(bitset) =3D=3D len(tags)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if best_width !=3D 0:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k
>> +=C2=A0=C2=A0=C2=A0 if best_width =3D=3D 0:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise Exception('Could not f=
ind a way to differentiate the=20
>> encodings ' +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 'of the following=20
>> tags:\n{}'.format('\n'.join(tags)))
>> +=C2=A0=C2=A0=C2=A0 if caught_all_tags:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for width in range(1, best_w=
idth):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for =
lsb in range(enc_width - width, -1, -1):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bitset =3D set([encs[tag][lsb:lsb+width] for tag in t=
ags])
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if all(differentiator_opcode_bit[lsb:lsb+width]) and =
\
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len(bitset) =3D=3D len(tags):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 best_width =3D width
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 best_lsb =3D lsb
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else=
:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 continue
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k
>> +=C2=A0=C2=A0=C2=A0 node['separator_lsb'] =3D best_lsb
>> +=C2=A0=C2=A0=C2=A0 node['separator_width'] =3D best_width
>> +=C2=A0=C2=A0=C2=A0 node['children'] =3D []
>> +=C2=A0=C2=A0=C2=A0 for value in range(2 ** best_width):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 child =3D {}
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bits =3D ''.join(reversed('{=
:0{}b}'.format(value, best_width)))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 child['leaves'] =3D \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set(=
[tag for tag in tags \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if encs[tag][best_lsb:best_lsb+best_width] =3D=3D bit=
s])
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node['children'].append(chil=
d)
>> +=C2=A0=C2=A0=C2=A0 for child in node['children']:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 auto_separate(child)
>> +
>> +auto_separate(dectree_normal)
>> +auto_separate(dectree_16bit)
>> +if subinsn_groupings:
>> +=C2=A0=C2=A0=C2=A0 auto_separate(dectree_subinsn_groupings)
>> +for dectree_subinsn in dectree_subinsns.values():
>> +=C2=A0=C2=A0=C2=A0 auto_separate(dectree_subinsn)
>> +for dectree_ext in dectree_extensions.values():
>> +=C2=A0=C2=A0=C2=A0 auto_separate(dectree_ext)
>> +
>> +for tag in faketags:
>> +=C2=A0=C2=A0=C2=A0 del encs[tag]
>> +
>> +def table_name(parents, node):
>> +=C2=A0=C2=A0=C2=A0 path =3D parents + [node]
>> +=C2=A0=C2=A0=C2=A0 root =3D path[0]
>> +=C2=A0=C2=A0=C2=A0 tag =3D next(iter(node['leaves']))
>> +=C2=A0=C2=A0=C2=A0 if tag in subinsn_groupings:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enc_width =3D len(subinsn_gr=
oupings[tag]['enc'].replace(' ', ''))
>> +=C2=A0=C2=A0=C2=A0 else:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tag =3D next(iter(node['leav=
es'] - faketags))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enc_width =3D len(encs[tag])
>> +=C2=A0=C2=A0=C2=A0 determining_bits =3D ['_'] * enc_width
>> +=C2=A0=C2=A0=C2=A0 for (parent, child) in zip(path[:-1], path[1:]):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lsb =3D parent['separator_ls=
b']
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width =3D parent['separator_=
width']
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D parent['children']=
.index(child)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 determining_bits[lsb:lsb+wid=
th] =3D \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list=
(reversed('{:0{}b}'.format(value, width)))
>> +=C2=A0=C2=A0=C2=A0 if tag in subinsn_groupings:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name =3D 'DECODE_ROOT_EE'
>> +=C2=A0=C2=A0=C2=A0 else:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enc_class =3D iset.iset[tag]=
['enc_class']
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if enc_class in ext_enc_clas=
ses:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name=
 =3D 'DECODE_EXT_{}'.format(enc_class)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 elif enc_class in subinsn_en=
c_classes:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name=
 =3D 'DECODE_SUBINSN_{}'.format(enc_class)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name=
 =3D 'DECODE_ROOT_{}'.format(enc_width)
>> +=C2=A0=C2=A0=C2=A0 if node !=3D root:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name +=3D '_' + ''.join(reve=
rsed(determining_bits))
>> +=C2=A0=C2=A0=C2=A0 return name
>> +
>> +def print_node(f, node, parents):
>> +=C2=A0=C2=A0=C2=A0 if len(node['leaves']) <=3D 1:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return
>> +=C2=A0=C2=A0=C2=A0 name =3D table_name(parents, node)
>> +=C2=A0=C2=A0=C2=A0 lsb =3D node['separator_lsb']
>> +=C2=A0=C2=A0=C2=A0 width =3D node['separator_width']
>> +=C2=A0=C2=A0=C2=A0 print('DECODE_NEW_TABLE({},{},DECODE_SEPARATOR_BITS(=
{},{}))'.\
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 format(name, 2 ** width, lsb=
, width), file=3Df)
>> +=C2=A0=C2=A0=C2=A0 for child in node['children']:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if len(child['leaves']) =3D=
=3D 0:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prin=
t('INVALID()', file=3Df)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 elif len(child['leaves']) =
=3D=3D 1:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (tag=
,) =3D child['leaves']
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if t=
ag in subinsn_groupings:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 class_a =3D subinsn_groupings[tag]['class_a']
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 class_b =3D subinsn_groupings[tag]['class_b']
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 enc =3D subinsn_groupings[tag]['enc'].replace(' ', ''=
)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if 'RESERVED' in tag:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print('INVALID()', file=3Df)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 else:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print('SUBINSNS({},{},{},"{}"=
)'.\
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 forma=
t(tag, class_a, class_b, enc), file=3Df)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 elif=
 tag in iset.enc_ext_spaces:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 enc =3D iset.enc_ext_spaces[tag].replace(' ', '')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 print('EXTSPACE({},"{}")'.format(tag, enc), file=3Df)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else=
:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 enc =3D ''.join(reversed(encs[tag]))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 print('TERMINAL({},"{}")'.format(tag, enc), file=3Df)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prin=
t('TABLE_LINK({})'.format(table_name(parents +=20
>> [node], child)),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file=3Df)
>> +=C2=A0=C2=A0=C2=A0 print('DECODE_END_TABLE({},{},DECODE_SEPARATOR_BITS(=
{},{}))'.\
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 format(name, 2 ** width, lsb=
, width), file=3Df)
>> +=C2=A0=C2=A0=C2=A0 print(file=3Df)
>> +=C2=A0=C2=A0=C2=A0 parents.append(node)
>> +=C2=A0=C2=A0=C2=A0 for child in node['children']:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_node(f, child, parents=
)
>> +=C2=A0=C2=A0=C2=A0 parents.pop()
>> +
>> +def print_tree(f, tree):
>> +=C2=A0=C2=A0=C2=A0 print_node(f, tree, [])
>> +
>> +def print_match_info(f):
>> +=C2=A0=C2=A0=C2=A0 for tag in sorted(encs.keys(), key=3Diset.tags.index=
):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enc =3D ''.join(reversed(enc=
s[tag]))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask =3D int(re.sub(r'[^1]',=
 r'0', enc.replace('0', '1')), 2)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 match =3D int(re.sub(r'[^01]=
', r'0', enc), 2)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 suffix =3D ''
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print('DECODE{}_MATCH_INFO({=
},0x{:x}U,0x{:x}U)'.\
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 form=
at(suffix, tag, mask, match), file=3Df)
>> +
>> +regre =3D re.compile(
>> +=C2=A0=C2=A0=C2=A0 r'((?<!DUP)[MNORCPQXSGVZA])([stuvwxyzdefg]+)([.]?[Ll=
Hh]?)(\d+S?)')
>> +immre =3D re.compile(r'[#]([rRsSuUm])(\d+)(?:[:](\d+))?')
>> +
>> +def ordered_unique(l):
>> +=C2=A0=C2=A0=C2=A0 return sorted(set(l), key=3Dl.index)
>> +
>> +implicit_registers =3D {
>> +=C2=A0=C2=A0=C2=A0 'SP' : 29,
>> +=C2=A0=C2=A0=C2=A0 'FP' : 30,
>> +=C2=A0=C2=A0=C2=A0 'LR' : 31
>> +}
>> +
>> +num_registers =3D {
>> +=C2=A0=C2=A0=C2=A0 'R' : 32,
>> +=C2=A0=C2=A0=C2=A0 'V' : 32
>> +}
>> +
>> +def print_op_info(f):
>> +=C2=A0=C2=A0=C2=A0 for tag in sorted(encs.keys(), key=3Diset.tags.index=
):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enc =3D encs[tag]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print(file=3Df)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print('DECODE_OPINFO({},'.fo=
rmat(tag), file=3Df)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regs =3D ordered_unique(regr=
e.findall(iset.iset[tag]['syntax']))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imms =3D ordered_unique(immr=
e.findall(iset.iset[tag]['syntax']))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regno =3D 0
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for reg in regs:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg_=
type =3D reg[0]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg_=
letter =3D reg[1][0]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg_=
num_choices =3D int(reg[3].rstrip('S'))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg_=
mapping =3D reg[0] + ''.join(['_' for letter in=20
>> reg[1]]) + reg[3]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg_=
enc_fields =3D re.findall(reg_letter + '+', enc)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if l=
en(reg_enc_fields) =3D=3D 0:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 raise Exception('Tag "{}" missing register=20
>> field!'.format(tag))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if l=
en(reg_enc_fields) > 1:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 raise Exception('Tag "{}" has split register field!'.=
\
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 format(tag))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg_=
enc_field =3D reg_enc_fields[0]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if 2=
 ** len(reg_enc_field) !=3D reg_num_choices:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 raise Exception('Tag "{}" has incorrect register=20
>> field width!'.\
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 format(tag))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prin=
t('=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DECODE_REG({},{},{})'.\
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 format(regno, len(reg_enc_field),=20
>> enc.index(reg_enc_field)),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file=3Df)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if r=
eg_type in num_registers and \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 reg_num_choices !=3D num_registers[reg_type]:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 print('=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEC=
ODE_MAPPED_REG({},{})'.\
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 format(regno, reg_mapping), f=
ile=3Df)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regn=
o +=3D 1
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def implicit_register_key(re=
g):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn implicit_registers[reg]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for reg in sorted(
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set(=
[r for r in (iset.iset[tag]['rregs'].split(',') + \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 iset.iset[tag]['wregs'].split(',')) \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if r in implicit_registers]),=
=20
>> key=3Dimplicit_register_key):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prin=
t('=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DECODE_IMPL_REG({},{})'.\
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 format(regno, implicit_registers[reg]), file=3Df)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regn=
o +=3D 1
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if imms and imms[0][0].isupp=
er():
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imms=
 =3D reversed(imms)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for imm in imms:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if i=
mm[0].isupper():
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 immno =3D 1
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else=
:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 immno =3D 0
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imm_=
type =3D imm[0]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imm_=
width =3D int(imm[1])
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imm_=
shift =3D imm[2]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if i=
mm_shift:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 imm_shift =3D int(imm_shift)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else=
:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 imm_shift =3D 0
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if i=
mm_type.islower():
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 imm_letter =3D 'i'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else=
:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 imm_letter =3D 'I'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rema=
inder =3D imm_width
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for =
m in reversed(list(re.finditer(imm_letter + '+', enc))):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 remainder -=3D m.end() - m.start()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 print('=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEC=
ODE_IMM({},{},{},{})'.\
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 format(immno, m.end() - m.sta=
rt(), m.start(),=20
>> remainder),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file=
=3Df)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if r=
emainder !=3D 0:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if imm[2]:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imm[2] =3D ':' + imm[2]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 raise Exception('Tag "{}" has an incorrect number of=
=20
>> ' + \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'encoding bits for immediate =
"{}"'.\
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 format(tag, ''.join(imm)))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if i=
mm_type.lower() in 'sr':
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 print('=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEC=
ODE_IMM_SXT({},{})'.\
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 format(immno, imm_width), fil=
e=3Df)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if i=
mm_type.lower() =3D=3D 'n':
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 print('=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEC=
ODE_IMM_NEG({},{})'.\
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 format(immno, imm_width), fil=
e=3Df)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if i=
mm_shift:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 print('=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEC=
ODE_IMM_SHIFT({},{})'.\
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 format(immno, imm_shift), fil=
e=3Df)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print(')', file=3Df)
>> +
>> +if __name__ =3D=3D '__main__':
>> +=C2=A0=C2=A0=C2=A0 f =3D cStringIO.StringIO()
>> +=C2=A0=C2=A0=C2=A0 print_tree(f, dectree_normal)
>> +=C2=A0=C2=A0=C2=A0 print_tree(f, dectree_16bit)
>> +=C2=A0=C2=A0=C2=A0 if subinsn_groupings:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_tree(f, dectree_subins=
n_groupings)
>> +=C2=A0=C2=A0=C2=A0 for (name, dectree_subinsn) in sorted(dectree_subins=
ns.items()):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_tree(f, dectree_subins=
n)
>> +=C2=A0=C2=A0=C2=A0 for (name, dectree_ext) in sorted(dectree_extensions=
.items()):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_tree(f, dectree_ext)
>> +=C2=A0=C2=A0=C2=A0 print_match_info(f)
>> +=C2=A0=C2=A0=C2=A0 print_op_info(f)
>> +=C2=A0=C2=A0=C2=A0 open('dectree_generated.h', 'w').write(f.getvalue())
>>
>=20
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


