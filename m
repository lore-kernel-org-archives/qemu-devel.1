Received: from eggs.gnu.org ([2001:4830:134:3::10]:50693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmcg5-00051M-VR
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmcg1-0002Kc-Jq
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:19:21 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dmcg1-0002K6-Ba
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:19:17 -0400
Received: by mail-wm0-x244.google.com with SMTP id j72so3054098wmi.3
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 02:19:17 -0700 (PDT)
Date: Tue, 29 Aug 2017 10:19:13 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170829091913.GD25960@stefanha-x1.localdomain>
References: <20170828015654.2530-1-Sergio.G.DelReal@gmail.com>
	<20170828015654.2530-4-Sergio.G.DelReal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170828015654.2530-4-Sergio.G.DelReal@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 03/14] hvf: add conditional macros around
 hvf code in cpus.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: qemu-devel@nongnu.org

On Sun, Aug 27, 2017 at 08:56:43PM -0500, Sergio Andres Gomez Del Real wrote:
> @@ -900,6 +904,11 @@ void cpu_synchronize_all_states(void)
>  
>      CPU_FOREACH(cpu) {
>          cpu_synchronize_state(cpu);
> +#ifdef CONFIG_HVF
> +        if (hvf_enabled()) {
> +            hvf_cpu_synchronize_state(cpu);
> +        }
> +#endif

Searching for CONFIG_KVM and CONFIG_HAX in cpus.c produces no results.
How do they solve the same problem without using #ifdef?  They define
nop stubs in "system/$ACCEL.h" so that cpus.c does not need #ifdefs.

Please follow the same approach for hvf.  Using stubs avoids "bitrot"
because the cpus.c kvm/hax code is always compiled, even when the
feature is disabled.  This way no compiler errors/warnings can hide in
the #ifdef regions that aren't compiled by most people.

Please avoid #ifdef whereever possible.
