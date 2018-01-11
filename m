Received: from eggs.gnu.org ([2001:4830:134:3::10]:41852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZiSA-0007CL-RS
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZiS7-0005tm-Nk
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:23:54 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:44613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZiS7-0005t3-FG
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:23:51 -0500
Received: by mail-pg0-x241.google.com with SMTP id m20so2814072pgc.11
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 11:23:51 -0800 (PST)
References: <20171218174552.18871-1-richard.henderson@linaro.org>
	<CAFEAcA9Qnj0G03x72BFLAYmodeBMDB=t3pz4JxUj0HvrbhkuGA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f82e02e3-40dd-8e74-6fe5-3205cdd42758@linaro.org>
Date: Thu, 11 Jan 2018 11:23:47 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Qnj0G03x72BFLAYmodeBMDB=t3pz4JxUj0HvrbhkuGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 00/23] target/arm: decode generator and
 initial sve patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 01/11/2018 09:56 AM, Peter Maydell wrote:
> On 18 December 2017 at 17:45, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> The most important part here, for review, is the first patch.
>>
>> I add a code generator, writen in python, which takes an input file
>> that describes the opcode bits and field bits of the instructions,
>> and outputs a function that does all of the decoding.
>>
>> The subsequent patches begin to add SVE support and also demonstrate
>> how I envision how both the decoder and the tcg host vector support
>> are to be used.  Thus, review of the direction would be appreciated
>> before there are another 100 patches along the same style.
> 
> This doesn't apply to master -- do you have an example of
> what the generated code comes out like?

That's why I gave you a link to a buildable branch on Tuesday.

But here's are some snippets from what's current in my tree.

Note that I play games with the decode and translation such that e.g. SETFFR ->
PTRUE p16, all; RDFFR pd -> ORR pd, p16, p16, p16.  That's what you'll be
seeing in the last dozen lines.  But I also chose that snippet because it shows
the nesting when instruction subsets need to decode more bits.


r~


    switch ((insn >> 24) & 0xff) {
    case 0x4:
        /* 00000100 ........ ........ ........ */
        switch (insn & 0x0020e000) {
        case 0x00000000:
            /* 00000100 ..0..... 000..... ........ */
            switch ((insn >> 16) & 0x1f) {
            case 0x0:
                /* 00000100 ..000000 000..... ........ */
                extract_rdn_pg_rm_esz(&u.f_rprr_esz, insn);
                trans_ADD_zpzz(ctx, &u.f_rprr_esz, insn);
                return true;
            case 0x1:
                /* 00000100 ..000001 000..... ........ */
                extract_rdn_pg_rm_esz(&u.f_rprr_esz, insn);
                trans_SUB_zpzz(ctx, &u.f_rprr_esz, insn);
                return true;
            case 0x3:
                /* 00000100 ..000011 000..... ........ */
                extract_rdm_pg_rn_esz(&u.f_rprr_esz, insn);
                trans_SUB_zpzz(ctx, &u.f_rprr_esz, insn);
                return true;
            case 0x8:
                /* 00000100 ..001000 000..... ........ */
                extract_rdn_pg_rm_esz(&u.f_rprr_esz, insn);
                trans_SMAX_zpzz(ctx, &u.f_rprr_esz, insn);
                return true;

...

            case 0x00100000:
                /* 00100101 ..01.... 11...... ...0.... */
                switch ((insn >> 17) & 0x7) {
                case 0x0:
                    /* 00100101 ..01000. 11...... ...0.... */
                    extract_Fmt_42(&u.f_22, insn);
                    switch (insn & 0x00c1020f) {
                    case 0x00400000:
                        /* 00100101 01010000 11....0. ...00000 */
                        trans_PTEST(ctx, &u.f_22, insn);
                        return true;
                    }
                    return false;
                case 0x4:
                    /* 00100101 ..01100. 11...... ...0.... */
                    switch ((insn >> 10) & 0xf) {
                    case 0x0:
                        /* 00100101 ..01100. 110000.. ...0.... */
                        extract_pd_pn(&u.f_rr_esz, insn);
                        switch (insn & 0x00c10200) {
                        case 0x00400000:
                            /* 00100101 01011000 1100000. ...0.... */
                            trans_PFIRST(ctx, &u.f_rr_esz, insn);
                            return true;
                        }
                        return false;
                    case 0x1:
                        /* 00100101 ..01100. 110001.. ...0.... */
                        extract_pd_pn_esz(&u.f_rr_esz, insn);
                        switch (insn & 0x00010200) {
                        case 0x00010000:
                            /* 00100101 ..011001 1100010. ...0.... */
                            trans_PNEXT(ctx, &u.f_rr_esz, insn);
                            return true;
                        }
                        return false;
                    case 0x8:
                        /* 00100101 ..01100. 111000.. ...0.... */
                        extract_Fmt_43(&u.f_ptrue, insn);
                        trans_PTRUE(ctx, &u.f_ptrue, insn);
                        return true;
                    case 0x9:
                        /* 00100101 ..01100. 111001.. ...0.... */
                        extract_Fmt_45(&u.f_ptrue, insn);
                        switch (insn & 0x00c103e0) {
                        case 0x00000000:
                            /* 00100101 00011000 11100100 0000.... */
                            trans_PTRUE(ctx, &u.f_ptrue, insn);
                            return true;
                        }
                        return false;
                    case 0xc:
                        /* 00100101 ..01100. 111100.. ...0.... */
                        switch (insn & 0x00810200) {
                        case 0x00000000:
                            /* 00100101 0.011000 1111000. ...0.... */
                            extract_Fmt_46(&u.f_rprr_s, insn);
                            trans_ORR_pppp(ctx, &u.f_rprr_s, insn);
                            return true;
                        case 0x00010000:
                            /* 00100101 0.011001 1111000. ...0.... */
                            extract_Fmt_47(&u.f_rprr_s, insn);
                            switch (insn & 0x004001e0) {
                            case 0x00000000:
                                /* 00100101 00011001 11110000 0000.... */
                                trans_ORR_pppp(ctx, &u.f_rprr_s, insn);
                                return true;
                            }
                            return false;
                        }
                        return false;
                    }
                    return false;
                }
                return false;
