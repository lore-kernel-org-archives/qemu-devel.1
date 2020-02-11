Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3A1C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:38:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B99AF206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4YARaxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99AF206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Q7S-00026B-RF
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 02:38:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1Q6o-0001er-1j
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:37:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1Q6l-0002VP-AX
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:37:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59868
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1Q6l-0002Un-63
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581406642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kqVb7yP8vFlaz4h0gSvIyCtJrVOiPLV68edwxDFRdTc=;
 b=V4YARaxHYOE3LNG59ZfP4koo7VYNBoB8Vxm5lHyYRYcxCWVfOzU0PKSvWDE/Jfn9HQxe+I
 yGOmn48jy2FOzXrUrMJcQQlWL9Pzw1DHXPCuXahYgmpIgbiNYhg08AQPBqESnSfCOw9N+m
 eeaHkm8GD2c19SU6xlRuAbYuKvq/OLw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-VD00fRjeO1KI1nJaG5OIkQ-1; Tue, 11 Feb 2020 02:37:17 -0500
Received: by mail-wr1-f72.google.com with SMTP id l1so6491793wrt.4
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 23:37:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=drXTPBgmjDZF2HIBTsUzzjEK8uVk9ScVC8yfiO7167M=;
 b=MDjS6DQ7fsvCoGDDVd/9uQ9ZEkcHTlHZ9yxRSrVmB9ykVmBmzp0bdA6du3ze+qiSt1
 0NqcfJzIE6jeiQ7q6/WTkpY0maNiuB112rZx20xAhmOKelfldsObjO3v9vyfj1+J+zgd
 YpHtKy2zICbLZ2zSebbIcu/bk+DjtDwb0EDv5MVa7GK22VfFoCFXuoNr9ByzL+KtZ4Vu
 G6K+mUIzsFk2HPjeodutEJTKAYzdS8y7/hj3QReJX+MB8NJZNAMNtrqv/tPl45urtNK/
 yZY1avCQdR9HHT0pJM44XQb0ZjKBhq5P6Sug8fdNMhbWHJSXwNH5TtrN3w6DxogxmBhx
 J1kw==
X-Gm-Message-State: APjAAAVOmIqBkjRnaG/ZfutB3uqs/MANJOqBb3Xt9Qy8qWjnDwRBi/8Z
 E+yZSjAYdyl8LsYqiHHi+hYhSJ6vb7rRUlzbVKudogKyrS0fvY9pRTTH227GZsgs1Dl46A6N8sW
 +MZ/O/wTikbDSyQA=
X-Received: by 2002:adf:e746:: with SMTP id c6mr6544036wrn.323.1581406636306; 
 Mon, 10 Feb 2020 23:37:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqybgT4cracZeILFTsphvaxuhZ+vtERfcV8k72BH2+uCR5v4FTHlCDX/HeaTACUy3JERdiSrSg==
X-Received: by 2002:adf:e746:: with SMTP id c6mr6544007wrn.323.1581406635922; 
 Mon, 10 Feb 2020 23:37:15 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id e17sm2516764wma.12.2020.02.10.23.37.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 23:37:15 -0800 (PST)
Subject: Re: [RFC PATCH 28/66] Hexagon generater phase 4 - Decode tree
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
 <1581381644-13678-29-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8de75140-9592-7740-12e7-da1ed1d0ee27@redhat.com>
Date: Tue, 11 Feb 2020 08:37:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581381644-13678-29-git-send-email-tsimpson@quicinc.com>
Content-Language: en-US
X-MC-Unique: VD00fRjeO1KI1nJaG5OIkQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On 2/11/20 1:40 AM, Taylor Simpson wrote:
> Python script that emits the decode tree in dectree_generated.h.
>=20
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>   target/hexagon/dectree.py | 354 +++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 354 insertions(+)
>   create mode 100755 target/hexagon/dectree.py
>=20
> diff --git a/target/hexagon/dectree.py b/target/hexagon/dectree.py
> new file mode 100755
> index 0000000..a0435c9
> --- /dev/null
> +++ b/target/hexagon/dectree.py
> @@ -0,0 +1,354 @@
> +#!/usr/bin/env python

python3

> +
> +from __future__ import print_function

Not needed anymore.

> +##
> +##  Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reser=
ved.
> +##
> +##  This program is free software; you can redistribute it and/or modify
> +##  it under the terms of the GNU General Public License as published by
> +##  the Free Software Foundation; either version 2 of the License, or
> +##  (at your option) any later version.
> +##
> +##  This program is distributed in the hope that it will be useful,
> +##  but WITHOUT ANY WARRANTY; without even the implied warranty of
> +##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +##  GNU General Public License for more details.
> +##
> +##  You should have received a copy of the GNU General Public License
> +##  along with this program; if not, see <http://www.gnu.org/licenses/>.
> +##
> +
> +import cStringIO
> +import re
> +
> +import sys
> +sys.path.insert(0, sys.argv[1])
> +import iset
> +
> +encs =3D {tag : ''.join(reversed(iset.iset[tag]['enc'].replace(' ', ''))=
)
> +    for tag in iset.tags if iset.iset[tag]['enc'] !=3D 'MISSING ENCODING=
'}
> +
> +enc_classes =3D set([iset.iset[tag]['enc_class'] for tag in encs.keys()]=
)
> +subinsn_enc_classes =3D \
> +    set([enc_class for enc_class in enc_classes \
> +        if enc_class.startswith('SUBINSN_')])
> +ext_enc_classes =3D \
> +    set([enc_class for enc_class in enc_classes \
> +        if enc_class not in ('NORMAL', '16BIT') and \
> +           not enc_class.startswith('SUBINSN_')])
> +
> +try:
> +    subinsn_groupings =3D iset.subinsn_groupings
> +except AttributeError:
> +    subinsn_groupings =3D {}
> +
> +for (tag, subinsn_grouping) in subinsn_groupings.items():
> +    encs[tag] =3D ''.join(reversed(subinsn_grouping['enc'].replace(' ', =
'')))
> +
> +dectree_normal =3D {'leaves' : set()}
> +dectree_16bit =3D {'leaves' : set()}
> +dectree_subinsn_groupings =3D {'leaves' : set()}
> +dectree_subinsns =3D {name : {'leaves' : set()} for name in subinsn_enc_=
classes}
> +dectree_extensions =3D {name : {'leaves' : set()} for name in ext_enc_cl=
asses}
> +
> +for tag in encs.keys():
> +    if tag in subinsn_groupings:
> +        dectree_subinsn_groupings['leaves'].add(tag)
> +        continue
> +    enc_class =3D iset.iset[tag]['enc_class']
> +    if enc_class.startswith('SUBINSN_'):
> +        if len(encs[tag]) !=3D 32:
> +            encs[tag] =3D encs[tag] + '0' * (32 - len(encs[tag]))
> +        dectree_subinsns[enc_class]['leaves'].add(tag)
> +    elif  enc_class =3D=3D '16BIT':
> +        if len(encs[tag]) !=3D 16:
> +            raise Exception('Tag "{}" has enc_class "{}" and not an enco=
ding ' +
> +                            'width of 16 bits!'.format(tag, enc_class))
> +        dectree_16bit['leaves'].add(tag)
> +    else:
> +        if len(encs[tag]) !=3D 32:
> +            raise Exception('Tag "{}" has enc_class "{}" and not an enco=
ding ' +
> +                            'width of 32 bits!'.format(tag, enc_class))
> +        if enc_class =3D=3D 'NORMAL':
> +            dectree_normal['leaves'].add(tag)
> +        else:
> +            dectree_extensions[enc_class]['leaves'].add(tag)
> +
> +faketags =3D set()
> +for (tag, enc) in iset.enc_ext_spaces.items():
> +    faketags.add(tag)
> +    encs[tag] =3D ''.join(reversed(enc.replace(' ', '')))
> +    dectree_normal['leaves'].add(tag)
> +
> +faketags |=3D set(subinsn_groupings.keys())
> +
> +def every_bit_counts(bitset):
> +    for i in range(1, len(next(iter(bitset)))):
> +        if len(set([bits[:i] + bits[i+1:] for bits in bitset])) =3D=3D l=
en(bitset):
> +            return False
> +    return True
> +
> +def auto_separate(node):
> +    tags =3D node['leaves']
> +    if len(tags) <=3D 1:
> +        return
> +    enc_width =3D len(encs[next(iter(tags))])
> +    opcode_bit_for_all =3D \
> +        [all([encs[tag][i] in '01' \
> +            for tag in tags]) for i in range(enc_width)]
> +    opcode_bit_is_0_for_all =3D \
> +        [opcode_bit_for_all[i] and all([encs[tag][i] =3D=3D '0' \
> +            for tag in tags]) for i in range(enc_width)]
> +    opcode_bit_is_1_for_all =3D \
> +        [opcode_bit_for_all[i] and all([encs[tag][i] =3D=3D '1' \
> +            for tag in tags]) for i in range(enc_width)]
> +    differentiator_opcode_bit =3D \
> +        [opcode_bit_for_all[i] and \
> +         not (opcode_bit_is_0_for_all[i] or \
> +         opcode_bit_is_1_for_all[i]) \
> +            for i in range(enc_width)]
> +    best_width =3D 0
> +    for width in range(4, 0, -1):
> +        for lsb in range(enc_width - width, -1, -1):
> +            bitset =3D set([encs[tag][lsb:lsb+width] for tag in tags])
> +            if all(differentiator_opcode_bit[lsb:lsb+width]) and \
> +                (len(bitset) =3D=3D len(tags) or every_bit_counts(bitset=
)):
> +                best_width =3D width
> +                best_lsb =3D lsb
> +                caught_all_tags =3D len(bitset) =3D=3D len(tags)
> +                break
> +        if best_width !=3D 0:
> +            break
> +    if best_width =3D=3D 0:
> +        raise Exception('Could not find a way to differentiate the encod=
ings ' +
> +                         'of the following tags:\n{}'.format('\n'.join(t=
ags)))
> +    if caught_all_tags:
> +        for width in range(1, best_width):
> +            for lsb in range(enc_width - width, -1, -1):
> +                bitset =3D set([encs[tag][lsb:lsb+width] for tag in tags=
])
> +                if all(differentiator_opcode_bit[lsb:lsb+width]) and \
> +                    len(bitset) =3D=3D len(tags):
> +                    best_width =3D width
> +                    best_lsb =3D lsb
> +                    break
> +            else:
> +                continue
> +            break
> +    node['separator_lsb'] =3D best_lsb
> +    node['separator_width'] =3D best_width
> +    node['children'] =3D []
> +    for value in range(2 ** best_width):
> +        child =3D {}
> +        bits =3D ''.join(reversed('{:0{}b}'.format(value, best_width)))
> +        child['leaves'] =3D \
> +            set([tag for tag in tags \
> +                if encs[tag][best_lsb:best_lsb+best_width] =3D=3D bits])
> +        node['children'].append(child)
> +    for child in node['children']:
> +        auto_separate(child)
> +
> +auto_separate(dectree_normal)
> +auto_separate(dectree_16bit)
> +if subinsn_groupings:
> +    auto_separate(dectree_subinsn_groupings)
> +for dectree_subinsn in dectree_subinsns.values():
> +    auto_separate(dectree_subinsn)
> +for dectree_ext in dectree_extensions.values():
> +    auto_separate(dectree_ext)
> +
> +for tag in faketags:
> +    del encs[tag]
> +
> +def table_name(parents, node):
> +    path =3D parents + [node]
> +    root =3D path[0]
> +    tag =3D next(iter(node['leaves']))
> +    if tag in subinsn_groupings:
> +        enc_width =3D len(subinsn_groupings[tag]['enc'].replace(' ', '')=
)
> +    else:
> +        tag =3D next(iter(node['leaves'] - faketags))
> +        enc_width =3D len(encs[tag])
> +    determining_bits =3D ['_'] * enc_width
> +    for (parent, child) in zip(path[:-1], path[1:]):
> +        lsb =3D parent['separator_lsb']
> +        width =3D parent['separator_width']
> +        value =3D parent['children'].index(child)
> +        determining_bits[lsb:lsb+width] =3D \
> +            list(reversed('{:0{}b}'.format(value, width)))
> +    if tag in subinsn_groupings:
> +        name =3D 'DECODE_ROOT_EE'
> +    else:
> +        enc_class =3D iset.iset[tag]['enc_class']
> +        if enc_class in ext_enc_classes:
> +            name =3D 'DECODE_EXT_{}'.format(enc_class)
> +        elif enc_class in subinsn_enc_classes:
> +            name =3D 'DECODE_SUBINSN_{}'.format(enc_class)
> +        else:
> +            name =3D 'DECODE_ROOT_{}'.format(enc_width)
> +    if node !=3D root:
> +        name +=3D '_' + ''.join(reversed(determining_bits))
> +    return name
> +
> +def print_node(f, node, parents):
> +    if len(node['leaves']) <=3D 1:
> +        return
> +    name =3D table_name(parents, node)
> +    lsb =3D node['separator_lsb']
> +    width =3D node['separator_width']
> +    print('DECODE_NEW_TABLE({},{},DECODE_SEPARATOR_BITS({},{}))'.\
> +        format(name, 2 ** width, lsb, width), file=3Df)
> +    for child in node['children']:
> +        if len(child['leaves']) =3D=3D 0:
> +            print('INVALID()', file=3Df)
> +        elif len(child['leaves']) =3D=3D 1:
> +            (tag,) =3D child['leaves']
> +            if tag in subinsn_groupings:
> +                class_a =3D subinsn_groupings[tag]['class_a']
> +                class_b =3D subinsn_groupings[tag]['class_b']
> +                enc =3D subinsn_groupings[tag]['enc'].replace(' ', '')
> +                if 'RESERVED' in tag:
> +                    print('INVALID()', file=3Df)
> +                else:
> +                    print('SUBINSNS({},{},{},"{}")'.\
> +                        format(tag, class_a, class_b, enc), file=3Df)
> +            elif tag in iset.enc_ext_spaces:
> +                enc =3D iset.enc_ext_spaces[tag].replace(' ', '')
> +                print('EXTSPACE({},"{}")'.format(tag, enc), file=3Df)
> +            else:
> +                enc =3D ''.join(reversed(encs[tag]))
> +                print('TERMINAL({},"{}")'.format(tag, enc), file=3Df)
> +        else:
> +            print('TABLE_LINK({})'.format(table_name(parents + [node], c=
hild)),
> +                  file=3Df)
> +    print('DECODE_END_TABLE({},{},DECODE_SEPARATOR_BITS({},{}))'.\
> +        format(name, 2 ** width, lsb, width), file=3Df)
> +    print(file=3Df)
> +    parents.append(node)
> +    for child in node['children']:
> +        print_node(f, child, parents)
> +    parents.pop()
> +
> +def print_tree(f, tree):
> +    print_node(f, tree, [])
> +
> +def print_match_info(f):
> +    for tag in sorted(encs.keys(), key=3Diset.tags.index):
> +        enc =3D ''.join(reversed(encs[tag]))
> +        mask =3D int(re.sub(r'[^1]', r'0', enc.replace('0', '1')), 2)
> +        match =3D int(re.sub(r'[^01]', r'0', enc), 2)
> +        suffix =3D ''
> +        print('DECODE{}_MATCH_INFO({},0x{:x}U,0x{:x}U)'.\
> +            format(suffix, tag, mask, match), file=3Df)
> +
> +regre =3D re.compile(
> +    r'((?<!DUP)[MNORCPQXSGVZA])([stuvwxyzdefg]+)([.]?[LlHh]?)(\d+S?)')
> +immre =3D re.compile(r'[#]([rRsSuUm])(\d+)(?:[:](\d+))?')
> +
> +def ordered_unique(l):
> +    return sorted(set(l), key=3Dl.index)
> +
> +implicit_registers =3D {
> +    'SP' : 29,
> +    'FP' : 30,
> +    'LR' : 31
> +}
> +
> +num_registers =3D {
> +    'R' : 32,
> +    'V' : 32
> +}
> +
> +def print_op_info(f):
> +    for tag in sorted(encs.keys(), key=3Diset.tags.index):
> +        enc =3D encs[tag]
> +        print(file=3Df)
> +        print('DECODE_OPINFO({},'.format(tag), file=3Df)
> +        regs =3D ordered_unique(regre.findall(iset.iset[tag]['syntax']))
> +        imms =3D ordered_unique(immre.findall(iset.iset[tag]['syntax']))
> +        regno =3D 0
> +        for reg in regs:
> +            reg_type =3D reg[0]
> +            reg_letter =3D reg[1][0]
> +            reg_num_choices =3D int(reg[3].rstrip('S'))
> +            reg_mapping =3D reg[0] + ''.join(['_' for letter in reg[1]])=
 + reg[3]
> +            reg_enc_fields =3D re.findall(reg_letter + '+', enc)
> +            if len(reg_enc_fields) =3D=3D 0:
> +                raise Exception('Tag "{}" missing register field!'.forma=
t(tag))
> +            if len(reg_enc_fields) > 1:
> +                raise Exception('Tag "{}" has split register field!'.\
> +                    format(tag))
> +            reg_enc_field =3D reg_enc_fields[0]
> +            if 2 ** len(reg_enc_field) !=3D reg_num_choices:
> +                raise Exception('Tag "{}" has incorrect register field w=
idth!'.\
> +                    format(tag))
> +            print('        DECODE_REG({},{},{})'.\
> +                format(regno, len(reg_enc_field), enc.index(reg_enc_fiel=
d)),
> +                       file=3Df)
> +            if reg_type in num_registers and \
> +                reg_num_choices !=3D num_registers[reg_type]:
> +                print('        DECODE_MAPPED_REG({},{})'.\
> +                    format(regno, reg_mapping), file=3Df)
> +            regno +=3D 1
> +        def implicit_register_key(reg):
> +            return implicit_registers[reg]
> +        for reg in sorted(
> +            set([r for r in (iset.iset[tag]['rregs'].split(',') + \
> +                iset.iset[tag]['wregs'].split(',')) \
> +                    if r in implicit_registers]), key=3Dimplicit_registe=
r_key):
> +            print('        DECODE_IMPL_REG({},{})'.\
> +                format(regno, implicit_registers[reg]), file=3Df)
> +            regno +=3D 1
> +        if imms and imms[0][0].isupper():
> +            imms =3D reversed(imms)
> +        for imm in imms:
> +            if imm[0].isupper():
> +                immno =3D 1
> +            else:
> +                immno =3D 0
> +            imm_type =3D imm[0]
> +            imm_width =3D int(imm[1])
> +            imm_shift =3D imm[2]
> +            if imm_shift:
> +                imm_shift =3D int(imm_shift)
> +            else:
> +                imm_shift =3D 0
> +            if imm_type.islower():
> +                imm_letter =3D 'i'
> +            else:
> +                imm_letter =3D 'I'
> +            remainder =3D imm_width
> +            for m in reversed(list(re.finditer(imm_letter + '+', enc))):
> +                remainder -=3D m.end() - m.start()
> +                print('        DECODE_IMM({},{},{},{})'.\
> +                    format(immno, m.end() - m.start(), m.start(), remain=
der),
> +                        file=3Df)
> +            if remainder !=3D 0:
> +                if imm[2]:
> +                    imm[2] =3D ':' + imm[2]
> +                raise Exception('Tag "{}" has an incorrect number of ' +=
 \
> +                    'encoding bits for immediate "{}"'.\
> +                    format(tag, ''.join(imm)))
> +            if imm_type.lower() in 'sr':
> +                print('        DECODE_IMM_SXT({},{})'.\
> +                    format(immno, imm_width), file=3Df)
> +            if imm_type.lower() =3D=3D 'n':
> +                print('        DECODE_IMM_NEG({},{})'.\
> +                    format(immno, imm_width), file=3Df)
> +            if imm_shift:
> +                print('        DECODE_IMM_SHIFT({},{})'.\
> +                    format(immno, imm_shift), file=3Df)
> +        print(')', file=3Df)
> +
> +if __name__ =3D=3D '__main__':
> +    f =3D cStringIO.StringIO()
> +    print_tree(f, dectree_normal)
> +    print_tree(f, dectree_16bit)
> +    if subinsn_groupings:
> +        print_tree(f, dectree_subinsn_groupings)
> +    for (name, dectree_subinsn) in sorted(dectree_subinsns.items()):
> +        print_tree(f, dectree_subinsn)
> +    for (name, dectree_ext) in sorted(dectree_extensions.items()):
> +        print_tree(f, dectree_ext)
> +    print_match_info(f)
> +    print_op_info(f)
> +    open('dectree_generated.h', 'w').write(f.getvalue())
>=20

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


