Received: from eggs.gnu.org ([2001:4830:134:3::10]:38425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW7fJ-0001qi-K0
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:26:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW7fG-000247-EJ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:26:05 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:36119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cW7fG-00023w-7A
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:26:02 -0500
Received: by mail-wm0-x22a.google.com with SMTP id c85so199408726wmi.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 12:26:02 -0800 (PST)
References: <20170119170507.16185-1-alex.bennee@linaro.org>
	<20170119170507.16185-6-alex.bennee@linaro.org>
	<aa263f40-8df0-2b55-0fc6-0634a22b15d9@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <aa263f40-8df0-2b55-0fc6-0634a22b15d9@twiddle.net>
Date: Tue, 24 Jan 2017 20:25:59 +0000
Message-ID: <87mveg9pd4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 05/27] tcg: add options for enabling
 MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: mttcg@greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, peter.maydell@linaro.org, claudio.fontana@huawei.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>, jan.kiszka@siemens.com, mark.burton@greensocs.com, serge.fdrv@gmail.com, pbonzini@redhat.com, bamvor.zhangjian@linaro.org


Richard Henderson <rth@twiddle.net> writes:

> On 01/19/2017 09:04 AM, Alex Bennée wrote:
>> +void qemu_tcg_configure(QemuOpts *opts, Error **errp)
>> +{
>> +    const char *t = qemu_opt_get(opts, "thread");
>> +    if (t) {
>> +        if (strcmp(t, "multi") == 0) {
>> +            if (TCG_OVERSIZED_GUEST) {
>> +                error_setg(errp, "No MTTCG when guest word size > hosts");
>
> I agree with this, since I don't ever imagine it'll be fixed.  It's a silly use
> case in the first place considering the ubiquity of 64-bit hosts.

Funnily enough I know one kernel hacker who does use this to test their
arm64 kernels on their re-purposed armhf chromebooks. I've already
explained coming their way ;-)

>
>> +            } else if (!check_tcg_memory_orders_compatible()) {
>> +                error_setg(errp,
>> +                           "No MTTCG when guest MO is stronger than host MO");
>
> This, on the other hand, means that one cannot even force multi for testing.  A
> warning perhaps?

I did toy with making that a warning when I first wrote it. I'll make it so.

> And how shall we handle a guest translate adding barriers as
> necessary to satisfy host memory ordering?

We are talking about doing the necessary annotation to all a givens
targets loads and stores? I figured this code would morph and be tweaked
when (if?) we get there.

--
Alex Bennée
