Received: from eggs.gnu.org ([2001:4830:134:3::10]:57964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gKlUZ-0001Ng-TW
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gKlQI-0004O9-Iv
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:36:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:2444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gKlQI-0004Ma-9s
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:36:42 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181023152306.3123-1-david@redhat.com>
	<20181023152306.3123-2-david@redhat.com>
	<87pnvqdvsj.fsf@dusky.pond.sub.org>
	<e8fe86a1-d075-2ea8-d1f4-e08e5dceee07@redhat.com>
	<875zxingqn.fsf@dusky.pond.sub.org>
	<440eb166-73d1-77b6-5dd9-66a0abd7d665@redhat.com>
	<87muqn5ydc.fsf@dusky.pond.sub.org>
	<1ec41fe2-d4b4-fce2-9381-818ee3356409@redhat.com>
	<87tvkv2r2b.fsf@dusky.pond.sub.org>
	<64720ade-c69d-40a4-5359-2132711c01cd@redhat.com>
	<87d0rgvrbk.fsf@dusky.pond.sub.org>
	<fcbd588d-f51c-4ab4-fa45-ad5360aff5b1@redhat.com>
	<8736scq7y9.fsf@dusky.pond.sub.org>
	<bfebc5b0-cebd-8a83-3106-effba5332094@redhat.com>
	<878t24ort1.fsf@dusky.pond.sub.org>
	<50328c72-ec11-6158-bd44-018f7454de18@redhat.com>
Date: Thu, 08 Nov 2018 15:36:19 +0100
In-Reply-To: <50328c72-ec11-6158-bd44-018f7454de18@redhat.com> (David
	Hildenbrand's message of "Thu, 8 Nov 2018 14:05:29 +0100")
Message-ID: <877ehnmyak.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/7] qapi: use qemu_strtoi64() in
 parse_str
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

David Hildenbrand <david@redhat.com> writes:

> I found some more ugliness, looking at the tests. I am not sure the test
> is correct here.
>
> test_visitor_in_intList():
>
> v = visitor_input_test_init(data, "1,2,0,2-4,20,5-9,1-8");
>
> -> we expect { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 20 }, implying that the
> visitor actually does sorting + duplicate elimination. Now I consider
> this is wrong. We are parsing a list of integers, not an ordered set.
>
> What's your take on this?

I think you're right.  Visitors are tied to QAPI, and QAPI does *lists*,
not sets.  Lists are more general than sets.

I figure what drove development of this code was a need for sets, so
sets got implemented.  Review fail.

If the visitor does lists, whatever needs sets can convert the lists to
sets.

I'd advise against evolving the current code towards sanity.  Instead,
rewrite, and rely on tests to avoid unwanted changes in behavior.
