Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B55C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC34206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hPV5ull5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC34206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Q61-0000gk-35
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 02:36:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1Q4i-0007vN-Bg
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:35:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1Q4g-0000TH-J3
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:35:16 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31927
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1Q4g-0000Su-CY
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581406514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gzgoz2cvEDbaQZ03ucXvDIytGL0nvLBo6aO03seanHo=;
 b=hPV5ull5zNFArBAH6fsp2dzP8MPvfHrXo3Kv3RWPXXNZSrC/QCclTRGXXghQ/9q2QaOmsc
 xe3nR/2XM8kUKdWbWiQ6trEixNhupfPgWmVqfKqcpwvNEA2wKRYtWm17jRrM1jkA3SqPlb
 U8u+GmhVbVhtWbtSdjONLupNGTFkijo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-7y2lM94HMBuAEhOGBZeuKw-1; Tue, 11 Feb 2020 02:35:11 -0500
Received: by mail-wr1-f71.google.com with SMTP id s13so6434622wrb.21
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 23:35:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IWyuLK2Bnm9bEVYNzZcS7iVpJgQ9jzzRpBALnrVaYIY=;
 b=CHGKkRCXYeJM5fBG8VmNqTApuGg7SpGwX2arBH/verBYkORGI7RkfHM0pD1iZbkhKl
 +FyVAEOyY5U0LIueDzJdcwudWuPZ/V8zrerrLwgBwlVcblYQ60rgwkpwnUhkdbmGvY4b
 0cNlEDhzX7xDOkZzLh0gcrA62ONfPiKdfw7UKwoiJqx5fDWg05Gnl+XgyDo3TdOmqCef
 zFBmy0ng4Rtc20aj3li/14re+1QhG6QDvR6dlqeyLoDf1TsLbNyiuMqceqJ08VTE8hdp
 0J8RkutrmxUpMGnJpn2QpqX0zy4etEp/BvSLLtZNKi/Ed3PwouAtMQz35QI+fSwPD7Vo
 UjLg==
X-Gm-Message-State: APjAAAUvMaw25zyrI+su+JYmw7zvtIqAv0BIyH8qv8wq531CxfpvLqWG
 +HaduNeNpdeaT1lYFJUpQslgJE1Sid8QMBCZhmOBjKwJl/vFh/8DfKkxBBEbbOQZ6oOYIBR9556
 3loqGDEmPsBnDWaM=
X-Received: by 2002:a05:600c:251:: with SMTP id
 17mr3904904wmj.59.1581406510086; 
 Mon, 10 Feb 2020 23:35:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqzt2Ig0wq7Kd2BmzyHFMu4t9QAV+GM/dwR80tEMHfxly8NlzgnG/FSsiEDlHFpf2QnjDWPlJw==
X-Received: by 2002:a05:600c:251:: with SMTP id
 17mr3904864wmj.59.1581406509771; 
 Mon, 10 Feb 2020 23:35:09 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id t9sm2500466wmj.28.2020.02.10.23.35.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 23:35:09 -0800 (PST)
Subject: Re: [RFC PATCH 27/66] Hexagon generator phase 3 - C preprocessor for
 decode tree
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
 <1581381644-13678-28-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ffbf9869-2cc7-65f3-e92b-db11d474de74@redhat.com>
Date: Tue, 11 Feb 2020 08:35:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581381644-13678-28-git-send-email-tsimpson@quicinc.com>
Content-Language: en-US
X-MC-Unique: 7y2lM94HMBuAEhOGBZeuKw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 1:40 AM, Taylor Simpson wrote:
> Run the C preprocessor across the instruction definition and encoding
> files to expand macros and prepare the iset.py file.  The resulting
> fill contains python data structures used to build the decode tree.
>=20
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>   target/hexagon/gen_dectree_import.c | 205 +++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 205 insertions(+)
>   create mode 100644 target/hexagon/gen_dectree_import.c
>=20
> diff --git a/target/hexagon/gen_dectree_import.c b/target/hexagon/gen_dec=
tree_import.c
> new file mode 100644
> index 0000000..ad0779a
> --- /dev/null
> +++ b/target/hexagon/gen_dectree_import.c
> @@ -0,0 +1,205 @@
> +/*
> + *  Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reser=
ved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/*
> + * This program generates the encodings file that is processed by
> + * the dectree.py script to produce the decoding tree.  We use the C
> + * preprocessor to manipulate the files imported from the Hexagon
> + * architecture library.
> + */
> +#include <stdio.h>
> +#include <string.h>
> +#include "opcodes.h"
> +
> +#define STRINGIZE(X)    #X
> +
> +const char *opcode_names[] =3D {
> +#define OPCODE(IID) STRINGIZE(IID)
> +#include "opcodes_def_generated.h"
> +    NULL
> +#undef OPCODE
> +};
> +
> +char *opcode_syntax[XX_LAST_OPCODE];
> +
> +/*
> + * Process the instruction definitions
> + *     Scalar core instructions have the following form
> + *         Q6INSN(A2_add,"Rd32=3Dadd(Rs32,Rt32)",ATTRIBS(),
> + *         "Add 32-bit registers",
> + *         { RdV=3DRsV+RtV;})
> + *     HVX instructions have the following form
> + *         EXTINSN(V6_vinsertwr, "Vx32.w=3Dvinsert(Rt32)",
> + *         ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VX,A_CVI_LATE,A_NOTE_MPY_RESO=
URCE),
> + *         "Insert Word Scalar into Vector",
> + *         VxV.uw[0] =3D RtV;)
> + */
> +void opcode_init()
> +{
> +#define Q6INSN(TAG, BEH, ATTRIBS, DESCR, SEM) \
> +   opcode_syntax[TAG] =3D BEH;
> +#define EXTINSN(TAG, BEH, ATTRIBS, DESCR, SEM) \
> +   opcode_syntax[TAG] =3D BEH;
> +#include "imported/allidefs.def"
> +#undef Q6INSN
> +#undef EXTINSN
> +}
> +
> +const char *opcode_rregs[] =3D {
> +#define REGINFO(TAG, REGINFO, RREGS, WREGS) RREGS,
> +#define IMMINFO(TAG, SIGN, SIZE, SHAMT, SIGN2, SIZE2, SHAMT2)  /* nothin=
g */
> +#include "op_regs_generated.h"
> +    NULL
> +#undef REGINFO
> +#undef IMMINFO
> +};
> +
> +const char *opcode_wregs[] =3D {
> +#define REGINFO(TAG, REGINFO, RREGS, WREGS) WREGS,
> +#define IMMINFO(TAG, SIGN, SIZE, SHAMT, SIGN2, SIZE2, SHAMT2)  /* nothin=
g */
> +#include "op_regs_generated.h"
> +    NULL
> +#undef REGINFO
> +#undef IMMINFO
> +};
> +
> +opcode_encoding_t opcode_encodings[] =3D {
> +#define DEF_ENC32(TAG, ENCSTR) \
> +    [TAG] =3D { .encoding =3D ENCSTR },
> +#define DEF_ENC_SUBINSN(TAG, CLASS, ENCSTR) \
> +    [TAG] =3D { .encoding =3D ENCSTR, .enc_class =3D CLASS },
> +#define DEF_EXT_ENC(TAG, CLASS, ENCSTR) \
> +    [TAG] =3D { .encoding =3D ENCSTR, .enc_class =3D CLASS },
> +#include "imported/encode.def"
> +#undef DEF_ENC32
> +#undef DEF_ENC_SUBINSN
> +#undef DEF_EXT_ENC
> +};
> +
> +static const char * const opcode_enc_class_names[XX_LAST_ENC_CLASS] =3D =
{
> +    "NORMAL",
> +    "16BIT",
> +    "SUBINSN_A",
> +    "SUBINSN_L1",
> +    "SUBINSN_L2",
> +    "SUBINSN_S1",
> +    "SUBINSN_S2",
> +    "EXT_noext",
> +    "EXT_mmvec",
> +};
> +
> +static const char *get_opcode_enc(int opcode)
> +{
> +    const char *tmp =3D opcode_encodings[opcode].encoding;
> +    if (tmp =3D=3D NULL) {
> +        tmp =3D "MISSING ENCODING";
> +    }
> +    return tmp;
> +}
> +
> +static const char *get_opcode_enc_class(int opcode)
> +{
> +    const char *tmp =3D opcode_encodings[opcode].encoding;
> +    if (tmp =3D=3D NULL) {
> +        char *test =3D "V6_";        /* HVX */
> +        char *name =3D (char *)opcode_names[opcode];
> +        if (strncmp(name, test, strlen(test)) =3D=3D 0) {
> +            return "EXT_mmvec";
> +        }
> +    }
> +    return opcode_enc_class_names[opcode_encodings[opcode].enc_class];
> +}
> +
> +static void gen_iset_table(FILE *out)
> +{
> +    int i;
> +
> +    fprintf(out, "iset =3D {\n");
> +    for (i =3D 0; i < XX_LAST_OPCODE; i++) {
> +        fprintf(out, "\t\'%s\' : {\n", opcode_names[i]);
> +        fprintf(out, "\t\t\'tag\' : \'%s\',\n", opcode_names[i]);
> +        fprintf(out, "\t\t\'syntax\' : \'%s\',\n", opcode_syntax[i]);
> +        fprintf(out, "\t\t\'rregs\' : \'%s\',\n", opcode_rregs[i]);
> +        fprintf(out, "\t\t\'wregs\' : \'%s\',\n", opcode_wregs[i]);
> +        fprintf(out, "\t\t\'enc\' : \'%s\',\n", get_opcode_enc(i));
> +        fprintf(out, "\t\t\'enc_class\' : \'%s\',\n", get_opcode_enc_cla=
ss(i));
> +        fprintf(out, "\t},\n");
> +    }
> +    fprintf(out, "};\n\n");
> +}
> +
> +static void gen_tags_list(FILE *out)
> +{
> +    int i;
> +
> +    fprintf(out, "tags =3D [\n");
> +    for (i =3D 0; i < XX_LAST_OPCODE; i++) {
> +        fprintf(out, "\t\'%s\',\n", opcode_names[i]);
> +    }
> +    fprintf(out, "];\n\n");
> +}
> +
> +static void gen_enc_ext_spaces_table(FILE *out)
> +{
> +    fprintf(out, "enc_ext_spaces =3D {\n");
> +#define DEF_EXT_SPACE(SPACEID, ENCSTR) \
> +    fprintf(out, "\t\'%s\' : \'%s\',\n", #SPACEID, ENCSTR);
> +#include "imported/encode.def"
> +#undef DEF_EXT_SPACE
> +    fprintf(out, "};\n\n");
> +}
> +
> +static void gen_subinsn_groupings_table(FILE *out)
> +{
> +    fprintf(out, "subinsn_groupings =3D {\n");
> +#define DEF_PACKED32(TAG, TYPEA, TYPEB, ENCSTR) \
> +    do { \
> +        fprintf(out, "\t\'%s\' : {\n", #TAG); \
> +        fprintf(out, "\t\t\'name\' : \'%s\',\n", #TAG); \
> +        fprintf(out, "\t\t\'class_a\' : \'%s\',\n", #TYPEA); \
> +        fprintf(out, "\t\t\'class_b\' : \'%s\',\n", #TYPEB); \
> +        fprintf(out, "\t\t\'enc\' : \'%s\',\n", ENCSTR); \
> +        fprintf(out, "\t},\n"); \
> +    } while (0);
> +#include "imported/encode.def"
> +#undef DEF_PACKED32
> +    fprintf(out, "};\n\n");
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +    FILE *outfile;
> +
> +    if (argc !=3D 2) {
> +        fprintf(stderr, "Usage: gen_dectree_import ouptputfile\n");
> +        return -1;
> +    }
> +    outfile =3D fopen(argv[1], "w");
> +    if (outfile =3D=3D NULL) {
> +        fprintf(stderr, "Cannot open %s for writing\n", argv[1]);
> +        return -1;
> +    }
> +
> +    opcode_init();
> +    gen_iset_table(outfile);
> +    gen_tags_list(outfile);
> +    gen_enc_ext_spaces_table(outfile);
> +    gen_subinsn_groupings_table(outfile);
> +
> +    fclose(outfile);
> +    return 0;
> +}
>=20

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


