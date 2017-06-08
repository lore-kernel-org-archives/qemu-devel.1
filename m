Received: from eggs.gnu.org ([2001:4830:134:3::10]:53120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dIuVs-0002NP-Lw
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dIuVn-0007YC-Kz
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:18:00 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:43813)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dIuVn-0007Pk-CA
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:17:55 -0400
References: <7f44106b-c67e-2581-f59b-36a9796a9a36@upsilon.org.uk>
	<20170608100208.GA4145@stefanha-x1.localdomain>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <e25719b8-66ee-46e5-3c2d-f11a83d33629@msgid.tls.msk.ru>
Date: Thu, 8 Jun 2017 13:17:46 +0300
MIME-Version: 1.0
In-Reply-To: <20170608100208.GA4145@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] KVM guests fail to start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Cunningham <ml@upsilon.org.uk>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org

08.06.2017 13:02, Stefan Hajnoczi wrote:
> On Thu, Jun 08, 2017 at 08:42:58AM +0100, David Cunningham wrote:
>> Apologies if this list is inappropriate, I've failed to come across
>> anything pertinent via Google. If anyone can suggest a more appropriate
>> forum please do.
>>
>> I'm having a problem starting KVM guests since performing a routine
>> apt-get upgrade on a debian jessie system.
>>
>> On starting a guest via virt-manager I'm getting the below error.
>>
>> The same behaviour is seen with existing guests or newly created guests.
>>
>> Could anyone point me towards a solution, or debug course?
>>
>> Thanks...
>>
>>
>> Error starting domain: internal error: QEMU / QMP failed: Failed to open
>> module: /usr/lib/x86_64-linux-gnu/qemu/block-iscsi.so: undefined symbol:
>> aio_bh_schedule_oneshot
>> Failed to open module: /usr/lib/x86_64-linux-gnu/qemu/block-curl.so:
>> undefined symbol: aio_bh_schedule_oneshot
>> Failed to open module: /usr/lib/x86_64-linux-gnu/qemu/block-rbd.so:
>> undefined symbol: aio_bh_schedule_oneshot
>> Failed to open module: /usr/lib/x86_64-linux-gnu/qemu/block-ssh.so:
>> undefined symbol: inet_connect_saddr
> 
> Please make sure your qemu-block-extra and qemu-system-x86 packages are
> up-to-date.  They should both have the same version number.

The up-to-date thing isn't a requiriment, you can use any version of
your choice if it suits your needs.

The problem here is the version MISMATCH - qemu-system-x86 package
is from one version, while qemu-block-extra is from another.

qemu-block-extra package contains less-often-used block modules,
and in order to work, should be of the same version as corresponding
qemu-system-* package. I especially didn't use strong versioned
depencency here, in order to keep ability to try other versions of
qemu-system if some problem is found.

However, it seems like when qemu tries to load "wrong-versioned"
modules, it fails to _start_, which should not really happen.
It should ignore the wrong modules and continue, _unless_ you
actually use one of the block drivers in this package (only
in that case it should fail to start telling it didn't find
the requested block device).

Please for now ensure qemu-system-* and qemu-block-extra are
of the same version. We'll see what can be done to avoid this
prob in the future.

Thanks!

/mjt
