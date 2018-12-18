Received: from eggs.gnu.org ([2001:4830:134:3::10]:35051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gZ5gx-0006Rp-3y
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 22:05:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gZ5gt-0007FB-BB
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 22:05:06 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gZ5gt-0007EB-0S
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 22:05:03 -0500
Received: by mail-pf1-x444.google.com with SMTP id 64so7375627pfr.9
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 19:05:02 -0800 (PST)
References: <20181214015520.20467-1-aik@ozlabs.ru>
	<20181217062133.GK5597@umbus.fritz.box>
	<20181218020924.GB23604@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <1e2449a7-d89b-3ca5-db66-7da34ff59a35@ozlabs.ru>
Date: Tue, 18 Dec 2018 14:04:54 +1100
MIME-Version: 1.0
In-Reply-To: <20181218020924.GB23604@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v3] ppc/spapr: Receive and store
 device tree blob from SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, gkurz@linux.ibm.com



On 18/12/2018 13:09, David Gibson wrote:
> On Mon, Dec 17, 2018 at 05:21:33PM +1100, David Gibson wrote:
>> On Fri, Dec 14, 2018 at 12:55:20PM +1100, Alexey Kardashevskiy wrote:
>>> SLOF receives a device tree and updates it with various properties
>>> before switching to the guest kernel and QEMU is not aware of any changes
>>> made by SLOF. Since there is no real RTAS (QEMU implements it), it makes
>>> sense to pass the SLOF final device tree to QEMU to let it implement
>>> RTAS related tasks better, such as PCI host bus adapter hotplug.
>>>
>>> Specifially, now QEMU can find out the actual XICS phandle (for PHB
>>> hotplug) and the RTAS linux,rtas-entry/base properties (for firmware
>>> assisted NMI - FWNMI).
>>>
>>> This stores the initial DT blob in the sPAPR machine and replaces it
>>> in the KVMPPC_H_UPDATE_DT (new private hypercall) handler.
>>>
>>> This adds an @update_dt_enabled machine property to allow backward
>>> migration.
>>>
>>> SLOF already has a hypercall since
>>> https://github.com/aik/SLOF/commit/e6fc84652c9c0073f9183
>>>
>>> This makes use of the new fdt_check_full() helper. In order to allow
>>> the configure script to pick the correct DTC version, this adjusts
>>> the DTC presense test.
>>>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>
>> Applied, thanks.
> 
> And now, unapplied.
> 
> I don't know quite how, but somehow this patch is causing aarch64
> tests to SEGV.


/home/aik/p/qemu/configure --target-list=aarch64-softmmu
--source-path=/home/aik/p/qemu/ --disable-git-update --with-git=false
   --enable-trace-backend=log

and

make -C /home/aik/pbuild/qemu-localhost-aarch64-rel/ -j24 check

did not produce segv. I am running this all on a power8 box + ubuntu
1804, what is your config?



-- 
Alexey
