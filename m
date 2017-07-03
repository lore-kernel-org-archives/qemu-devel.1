Received: from eggs.gnu.org ([2001:4830:134:3::10]:60557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7oe-0004Pn-A0
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7ob-00049z-3z
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:19:28 -0400
Received: from mail-qk0-x234.google.com ([2607:f8b0:400d:c09::234]:33960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS7oa-00049X-To
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:19:25 -0400
Received: by mail-qk0-x234.google.com with SMTP id d78so153818056qkb.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 13:19:24 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-21-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9bf31fb2-a4a8-e3f7-5947-3a7d014281fe@twiddle.net>
Date: Mon, 3 Jul 2017 13:19:18 -0700
MIME-Version: 1.0
In-Reply-To: <1499099693-22903-21-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/22] target/i386: add the tcg_enabled()
 in target/i386/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

On 07/03/2017 09:34 AM, Paolo Bonzini wrote:
> @@ -215,10 +215,12 @@ void breakpoint_handler(CPUState *cs)
>       if (cs->watchpoint_hit) {
>           if (cs->watchpoint_hit->flags & BP_CPU) {
>               cs->watchpoint_hit = NULL;
> -            if (check_hw_breakpoints(env, false)) {
> -                raise_exception(env, EXCP01_DB);
> -            } else {
> -                cpu_loop_exit_noexc(cs);
> +            if (tcg_enabled()) {
> +                if (check_hw_breakpoints(env, false)) {
> +                    raise_exception(env, EXCP01_DB);
> +                } else {
> +                    cpu_loop_exit_noexc(cs);
> +                }

This seems like an odd place for the tcg_enabled check.  It seems like it 
should be much higher in the if/call chain.

Why are we doing all these bp checks only to disable the final raising of an 
exception?

Indeed, what in bpt_helper.c needs to be compiled in when !tcg_enabled?


r~
