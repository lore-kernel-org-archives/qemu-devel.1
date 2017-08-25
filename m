Received: from eggs.gnu.org ([2001:4830:134:3::10]:43352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dlCAf-00052w-Gy
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 06:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dlCAc-0007yr-G5
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 06:49:01 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dlCAc-0007yi-9C
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 06:48:58 -0400
Received: by mail-wm0-f41.google.com with SMTP id y71so68181wmd.0
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 03:48:58 -0700 (PDT)
References: <283a2a27-7fb5-5fa7-4921-60ba91f13666@ozlabs.ru>
	<20170818131853.GB17654@stefanha-x1.localdomain>
	<20170821043125.GH12356@umbus.fritz.box>
	<6e2ae379-9cff-9615-c19f-747867328cb5@ozlabs.ru>
	<acb8a5b9-559f-665c-9072-582f3ddc593b@ozlabs.ru>
	<20170824123006.GK5379@umbus.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7ee077ae-4e7e-8baf-9caa-9378f4a7b604@redhat.com>
Date: Fri, 25 Aug 2017 12:48:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170824123006.GK5379@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Memory use with >100 virtio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On 24/08/2017 14:30, David Gibson wrote:
>>
>> Ideas what to tweak or what valgrind tool to try?
> valgrind probably isn't that useful at this point.  I think we need to
> instrument bits of the code to find what the O(n^2) algo is and fix it.
> 
> Seems to me checking if the address_spaces list is growing to O(n^2)
> entries would be a good place to start.


The address spaces are O(n) (and so are the FlatView and the dispatch
tries), but each of them has O(n) size.

Eventually we use O(n^2) memory, but we build them O(n) times---which is
expensive and also means, due to RCU, that there can be a short amount
of time where it is between O(n^2) and O(n^3).

The scheme I suggested elsewhere in the thread should cut one "n", by
sharing one FlatViews and dispatch trie across all AddressSpaces.

Paolo
