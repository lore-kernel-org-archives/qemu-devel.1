Received: from eggs.gnu.org ([2001:4830:134:3::10]:54058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1daVSu-00018N-9k
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 19:11:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1daVSp-00034T-Ar
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 19:11:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1daVSp-00034A-3g
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 19:11:35 -0400
References: <1500761743-1669-1-git-send-email-zuban32s@gmail.com>
	<1500761743-1669-5-git-send-email-zuban32s@gmail.com>
	<20170726215625-mutt-send-email-mst@kernel.org>
	<CAKSfGUAh_rqGy8uNJXThH4v1z5zbPdLhkBx77Tui8PL-N-7JXw@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ea56b18e-b4fb-cfa0-d893-8bcd241ccdf4@redhat.com>
Date: Thu, 27 Jul 2017 01:11:22 +0200
MIME-Version: 1.0
In-Reply-To: <CAKSfGUAh_rqGy8uNJXThH4v1z5zbPdLhkBx77Tui8PL-N-7JXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [SeaBIOS] [RFC PATCH v2 4/6] hw/pci: introduce
 bridge-only vendor-specific capability to provide some hints to firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Bezzubikov <zuban32s@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: seabios@seabios.org, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com, Marcel Apfelbaum <marcel@redhat.com>, rth@twiddle.net

On 07/26/17 23:54, Alexander Bezzubikov wrote:
> 2017-07-26 22:43 GMT+03:00 Michael S. Tsirkin <mst@redhat.com>:
>> On Sun, Jul 23, 2017 at 01:15:41AM +0300, Aleksandr Bezzubikov wrote:

>>> +    PCIBridgeQemuCap cap;
>>
>> This leaks info to guest. You want to init all fields here:
>>
>> cap = {
>>  .len = ....
>> };
> 
> I surely can do this for len field, but as Laszlo proposed
> we can use mutually exclusive fields,
> e.g. pref_32 and pref_64, the only way I have left
> is to use ternary operator (if we surely need this
> big initializer). Keeping some if's would look better,
> I think.

I think it's fine to use "if"s in order to set up the structure
partially / gradually, but then please clear the structure up-front:


  PCIBridgeQemuCap cap = { 0 };

(In general "{ 0 }" is the best initializer ever, because it can
zero-init a variable of *any* type at all. Gcc might complain about the
inexact depth of {} nesting of course, but it's nonetheless valid C.)

Or else add a memset-to-zero.

Or else, do just

  PCIBridgeQemuCap cap = { .len = ... };

which will zero-fill every other field. ("[...] all subobjects that are
not initialized explicitly shall be initialized implicitly the same as
objects that have static storage duration").

Thanks
Laszlo
