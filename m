Received: from eggs.gnu.org ([2001:4830:134:3::10]:46366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d0Nwa-0000AW-1F
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 03:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d0NwX-00067h-0Q
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 03:53:00 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:32922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d0NwW-00066R-Ph
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 03:52:56 -0400
Received: by mail-wm0-x243.google.com with SMTP id o81so13011310wmb.0
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 00:52:56 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <cover.1492384862.git.shorne@gmail.com>
	<fb69c137317a365dcb549dfef1ecd2fbff48e92c.1492384862.git.shorne@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6914f9b7-ece1-973d-2210-871b71319ae0@twiddle.net>
Date: Tue, 18 Apr 2017 00:52:52 -0700
MIME-Version: 1.0
In-Reply-To: <fb69c137317a365dcb549dfef1ecd2fbff48e92c.1492384862.git.shorne@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] target/openrisc: add shutdown logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>, qemu-devel@nongnu.org
Cc: openrisc@lists.librecores.org

On 04/16/2017 04:23 PM, Stafford Horne wrote:
> In openrisc simulators we use hooks like 'l.nop 1' to cause the
> simulator to exit.  Implement that for qemu too.
>
> Reported-by: Waldemar Brodkorb <wbx@openadk.org>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

As I said the first time this was posted: This is horrible.

If you want to do something like this, it needs to be buried under a special 
run mode like -semihosting.

>          case 0x01:    /* l.nop */
>              LOG_DIS("l.nop %d\n", I16);
> +            {
> +                TCGv_i32 arg = tcg_const_i32(I16);
> +                gen_helper_nop(arg);
> +            }

You also really really must special-case l.nop 0 so that it doesn't generate a 
function call.  Just think of all the extra calls you're adding for every delay 
slot that couldn't be filled.


r~
