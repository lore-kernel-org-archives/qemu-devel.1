Received: from eggs.gnu.org ([209.51.188.92]:54782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL7tN-0005tL-Ob
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL7tM-00076a-9m
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:08:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hL7tM-0006Q1-0Z
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:08:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id c5so16545119wrs.11
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:07:54 -0700 (PDT)
References: <20190103144124.18917-1-stefanha@redhat.com>
	<CAFEAcA-B_T9E3ezWFXg-wp3RotMjv3-z3qY7hSJZEoqFBqCWnQ@mail.gmail.com>
	<62b29bc1-cc78-cd64-4377-fc4007ba7189@redhat.com>
	<20190426091702.GA2071@stefanha-x1.localdomain>
	<CAFEAcA8OVKO087uiNvwDGObiaxHAPYHwoXLEN1t5Y4v9B43r9A@mail.gmail.com>
	<20190429122819.GB7587@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <738394de-bd75-4ef3-10ef-de8cd07891de@redhat.com>
Date: Mon, 29 Apr 2019 17:07:51 +0200
MIME-Version: 1.0
In-Reply-To: <20190429122819.GB7587@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] Revert "armv7m: Guard against no -kernel
 argument"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, QEMU Developers <qemu-devel@nongnu.org>, Steffen Gortz <qemu.ml@steffen-goertz.de>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>



On 4/29/19 2:28 PM, Stefan Hajnoczi wrote:
> On Fri, Apr 26, 2019 at 12:45:37PM +0100, Peter Maydell wrote:
>> On Fri, 26 Apr 2019 at 10:17, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>> On Thu, Apr 25, 2019 at 08:07:06PM +0200, Philippe Mathieu-Daudé wrote:
>>> Old boards probably want to continue using -kernel.  New boards like
>>> microbit may use just -device loader.  Perhaps there is even a group
>>> that wants both options.
>>>
>>> A solution is to introduce explicit checks so that we can tell the user
>>> the appropriate option for the machine type.  I can work on this if you
>>> like, but probably won't be able to send a patch until Tuesday.
>>
>> But it's difficult to tell how to identify whether there's really
>> any guest code there. For instance the user might want to start
>> QEMU, connect via the gdbstub and load guest code from gdb.
>> Or they might be using the generic-loader device. Or they might
>> really be using -kernel but with a broken guest image which doesn't
>> have a vector table in it, which will result in the same message.
>> I guess you could have a heuristic for "if an M-profile CPU is in reset
>> and the value it loads for the starting PC is zero and the gdb
>> stub is not connected, then print a warning that the guest image
>> is missing or there's no vector table" but I'm not a big fan of
>> heuristics...
> 
> I was going to add a function to check kernel_filename and the presence
> of -device loader.  Then each machine type init function would call the
> function with flags indicating which modes are allowed:
> 
>   /* Allow both -kernel and -device loader */
>   check_kernel_loaded(KERNEL_CMDLINE | KERNEL_LOADER);
> 
>   /* Allow only -kernel */
>   check_kernel_loaded(KERNEL_CMDLINE);
> 
>   /* Allow only -device loader */
>   check_kernel_loaded(KERNEL_LOADER);
> 
> This doesn't support the gdbstub use case you've described though.  No
> heuristics but a bit inflexible.
> What do you think?

We can check for QEMU_OPTION_gdb/QEMU_OPTION_s, if present display
warning, else display error? Or no warning at all...
