Received: from eggs.gnu.org ([2001:4830:134:3::10]:57967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etF6Z-0001rE-4e
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:06:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etF6Y-0002Te-6a
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:06:19 -0500
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:43901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etF6Y-0002TJ-2F
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:06:18 -0500
Received: by mail-ot0-x235.google.com with SMTP id m22so18782613otf.10
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 08:06:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <46c35ebb-b0f9-9a55-b8b1-cd94a29cff3e@lauterbach.com>
References: <1519815685-29200-1-git-send-email-abdallah.bouassida@lauterbach.com>
	<1519815685-29200-4-git-send-email-abdallah.bouassida@lauterbach.com>
	<CAFEAcA88s2X9qkFVYG6kmeeZj6-bp0uskXb8TJF0HMfUVVSf8A@mail.gmail.com>
	<46c35ebb-b0f9-9a55-b8b1-cd94a29cff3e@lauterbach.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Mar 2018 16:05:56 +0000
Message-ID: <CAFEAcA8G+eYWZghEza9GmWfwK=cOf9xpS_dg7rkN5KZ50ak9HA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 3/4] target/arm: Add the XML dynamic
 generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Khaled Jmal <khaled.jmal@lauterbach.com>

On 6 March 2018 at 15:29, Abdallah Bouassida
<abdallah.bouassida@lauterbach.com> wrote:
> Hi Peter,
>>> diff --git a/gdbstub.c b/gdbstub.c
>>> index f1d5148..ffab30b 100644
>>> --- a/gdbstub.c
>>> +++ b/gdbstub.c
>>> @@ -665,6 +665,9 @@ static const char *get_feature_xml(const char *p, const char **newp,
>>>              pstrcat(target_xml, sizeof(target_xml), "<xi:include href=\"");
>>>              pstrcat(target_xml, sizeof(target_xml), cc->gdb_core_xml_file);
>>>              pstrcat(target_xml, sizeof(target_xml), "\"/>");
>>> +            if (cc->gdb_has_dynamic_xml) {
>>> +                cc->register_gdb_regs_for_features(cpu);
>>> +            }
>> I don't think we need a callback hook for this. You could just assume
>> the target code has already done whatever it needs. Specifically for
>> arm you can just make arm_cpu_register_gdb_regs_for_features() in helper.c
>> call gdb_register_coprocessor(..., "system-registers.xml",...) the
>> same way it already does for other xml files.
> I think in this case, for ARM64, if the execution mode has changed (to AARCH32) the time we connect
> to gdbstub then we will get the registers view of AARCH64 instead of AARCH32, as we have created
> our XML at the beginning (on arm_cpu_register_gdb_regs_for_feature()) where the CPU is
> on AARCH64.

The gdbstub code does not currently support guests flipping between
AArch32 and AArch64 -- it always exposes the AArch64 view of an
AArch64 CPU even if it happens to be in AArch32. This is obviously
unfortunate, but traditionally gdb has not supported the target
flipping architecture like this. I think that recent gdb changes
have enhanced the protocol to permit this, but adapting QEMU
to use them is a big job that you don't really want to make this
series be dependent on.

thanks
-- PMM
