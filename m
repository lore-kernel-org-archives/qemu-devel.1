Received: from eggs.gnu.org ([2001:4830:134:3::10]:44809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f6O3m-0005cC-9R
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 18:17:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f6O3j-0002hp-6A
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 18:17:46 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60831)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f6O3i-0002hQ-V1
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 18:17:43 -0400
Date: Wed, 11 Apr 2018 18:17:42 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180411221742.GA27538@flamenco>
References: <222EDB99-2ED5-4CCB-B550-7A02BC4BDC7F@psware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <222EDB99-2ED5-4CCB-B550-7A02BC4BDC7F@psware.com>
Subject: Re: [Qemu-devel] Bad icount read when running qemu-system-ppc64 and
 mfspr atbu guest instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Darrell Leinwand <darrell.leinwand@psware.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Wed, Apr 11, 2018 at 18:18:18 +0000, Darrell Leinwand wrote:
> Hi,
> 
> When I enable icount using an e5500 core I get an exit with “Bad icount read” when the guest software executes a load atbu command.
> 
> It looks like in qemu/accel/tcg/cpu_exec.c:166 sets can_do_io false when using icount.
>     cpu->can_do_io = !use_icount;
>     ret = tcg_qemu_tb_exec(env, tb_ptr);
>     cpu->can_do_io = 1;
> 
> Since can_do_io is set to false there and the cpu_get_icount_raw() function checks that flag qemu/cpus.c:260:
>         if (!cpu->can_do_io) {
>             fprintf(stderr, "Bad icount read\n");
>             exit(1);
>         }
> 
> The load_atbu function will always fail. I commented out the !use_icount and set it to a 1 in cpu_exec.c and it continues and seems to run normally, but I am not sure what side effects while running icount that could have since it may allow actual IO to occur while translation is happening.

Can you reproduce with the current master, i.e. 38e83a71d02 ?
A few patches have very recently been merged that might fix
your problem.

If master is still broken and it used to work in the past for you,
it would be useful if you could bisect this to point out the commit
that broke this.

Thanks,

		Emilio
