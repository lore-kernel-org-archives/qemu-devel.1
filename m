Received: from eggs.gnu.org ([2001:4830:134:3::10]:55033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVjwQ-0005Sy-51
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:06:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVjwN-0003Qi-Bu
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:06:10 -0500
Received: from mail-yb0-x242.google.com ([2607:f8b0:4002:c09::242]:33497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVjwN-0003QQ-7p
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:06:07 -0500
Received: by mail-yb0-x242.google.com with SMTP id 123so12130860ybe.0
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 11:06:07 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170119170507.16185-1-alex.bennee@linaro.org>
	<20170119170507.16185-6-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <aa263f40-8df0-2b55-0fc6-0634a22b15d9@twiddle.net>
Date: Mon, 23 Jan 2017 11:06:02 -0800
MIME-Version: 1.0
In-Reply-To: <20170119170507.16185-6-alex.bennee@linaro.org>
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, mttcg@greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com
Cc: peter.maydell@linaro.org, claudio.fontana@huawei.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>, jan.kiszka@siemens.com, mark.burton@greensocs.com, serge.fdrv@gmail.com, pbonzini@redhat.com, bamvor.zhangjian@linaro.org

On 01/19/2017 09:04 AM, Alex Bennée wrote:
> +void qemu_tcg_configure(QemuOpts *opts, Error **errp)
> +{
> +    const char *t = qemu_opt_get(opts, "thread");
> +    if (t) {
> +        if (strcmp(t, "multi") == 0) {
> +            if (TCG_OVERSIZED_GUEST) {
> +                error_setg(errp, "No MTTCG when guest word size > hosts");

I agree with this, since I don't ever imagine it'll be fixed.  It's a silly use
case in the first place considering the ubiquity of 64-bit hosts.

> +            } else if (!check_tcg_memory_orders_compatible()) {
> +                error_setg(errp,
> +                           "No MTTCG when guest MO is stronger than host MO");

This, on the other hand, means that one cannot even force multi for testing.  A
warning perhaps?  And how shall we handle a guest translate adding barriers as
necessary to satisfy host memory ordering?


r~
