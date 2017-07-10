Received: from eggs.gnu.org ([2001:4830:134:3::10]:47583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUeaQ-0006vc-VW
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUeaQ-0007S2-70
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:43:15 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170710192128.9048-1-alex.bennee@linaro.org>
	<20170710192128.9048-5-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e21159d2-42aa-1b08-5ea9-2f367a8e452f@twiddle.net>
Date: Mon, 10 Jul 2017 09:43:02 -1000
MIME-Version: 1.0
In-Reply-To: <20170710192128.9048-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/5] target/arm: use DISAS_JUMP for ISB
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org
Cc: qemu-devel@nongnu.org, "open list:ARM" <qemu-arm@nongnu.org>

On 07/10/2017 09:21 AM, Alex Bennée wrote:
> -        s->is_jmp = DISAS_UPDATE;
> +        gen_a64_set_pc_im(s->pc);
> +        s->is_jmp = DISAS_JUMP;

Better would be gen_goto_tb.  The destination is known, so there's no need to 
go through lookup_and_goto_ptr.  You still get the icount_decr check at the 
start of the linked TB, which is what you're looking for.

Interesting that a64's gen_goto_tb sets is_jmp, but a32 does not...


r~
