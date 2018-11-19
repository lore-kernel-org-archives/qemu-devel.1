Received: from eggs.gnu.org ([2001:4830:134:3::10]:60282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gOmmh-0001ka-BD
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 11:52:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gOmaV-00037b-GK
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 11:39:52 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:39304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gOmaV-00036u-4b
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 11:39:51 -0500
Received: by mail-ot1-x333.google.com with SMTP id g27so28216651oth.6
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 08:39:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9XbnnpTKDJQMHqxfChBaKp5j71gsxUYOCo2SQXkOZ9DQ@mail.gmail.com>
References: <20181108121646.26173-1-david@gibson.dropbear.id.au>
	<20181108121646.26173-2-david@gibson.dropbear.id.au>
	<CAFEAcA9XbnnpTKDJQMHqxfChBaKp5j71gsxUYOCo2SQXkOZ9DQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Nov 2018 16:39:29 +0000
Message-ID: <CAFEAcA_=jkQjVbZEvNd_5wboHo2poHUwiVSC66u9v5JGQDB6cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 01/22] target/ppc: add external PID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, Alexander Graf <agraf@suse.de>, Laurent Vivier <lvivier@redhat.com>, Roman Kapl <rka@sysgo.com>

On 15 November 2018 at 10:22, Peter Maydell <peter.maydell@linaro.org> wrote:
> Hi; Coverity reports an issue (CID1396864) with this function:
>
>> +/* dcbfep (external PID dcbf) */
>> +static void gen_dcbfep(DisasContext *ctx)
>> +{
>> +    /* XXX: specification says this is treated as a load by the MMU */
>> +    TCGv t0;
>> +    CHK_SV;
>> +    gen_set_access_type(ctx, ACCESS_CACHE);
>> +    t0 = tcg_temp_new();
>> +    gen_addr_reg_index(ctx, t0);
>> +    tcg_gen_qemu_ld_tl(t0, t0, PPC_TLB_EPID_LOAD, DEF_MEMOP(MO_UB));
>> +    tcg_temp_free(t0);
>> +}
>
> It says that the gen_set_access_type() call is unreachable. I think
> this is a false positive (the code is unreachable, but only if
> CONFIG_USER_ONLY is defined). On the other hand, all the other
> similar gen_* functions in this file that use CHK_SV seem to have
> a pattern of
>
> #if defined(CONFIG_USER_ONLY)
>     GEN_PRIV;
> #else
>     TCGv t0;
>     CHK_SV;
>     [etc]
> #endif
>
> so maybe we should do that here too for consistency?

I've marked the issue as a false-positive in Coverity (since it is,
and that's what we've done with some equivalent target/ppc Coverity
issues with other functions previously). I'll let you decide whether
you want to prefer "with ifdefs" or "without". (TBH I think the
"without" style is better here.)

thanks
-- PMM
