Received: from eggs.gnu.org ([2001:4830:134:3::10]:60768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gVGdA-0006lU-8e
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 08:57:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gVGd5-0003m5-Fx
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 08:57:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gVGd3-0003Pe-IW
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 08:57:19 -0500
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
	<1543851204-41186-19-git-send-email-pbonzini@redhat.com>
	<cf29d953-6833-3b1a-be1a-2ba444d71ae6@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <faf5bffe-3184-9972-0253-d1926667574c@redhat.com>
Date: Fri, 7 Dec 2018 14:57:07 +0100
MIME-Version: 1.0
In-Reply-To: <cf29d953-6833-3b1a-be1a-2ba444d71ae6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/71] tests/libqos: embed allocators
 instead of malloc-ing them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>

On 07/12/18 13:32, Thomas Huth wrote:
> On 2018-12-03 16:32, Paolo Bonzini wrote:
>> qgraph will embed these objects instead of allocating them in a separate
>> object.  Expose a new API "generic_alloc_init" and "generic_alloc_destroy"
>> for that, and rename the existing API with s/init/new/ and s/uninit/free/.
> 
> Could you please add a sentence *why* you are doing this? ... without
> that information, this just looks like a lot of unnecessary code churn...

The explanation is simply that if you allocate them separately you have
to define a destructor function to free it---more boilerplate and more
stuff that you can get wrong.  Therefore qgraph tries to use embedded
structs when something is always there (a "contains" edge).

The same is true for 16/71, you want to use heap-allocated PCI buses for
non-qgraph tests, but for a qgraph machine it would be very much
preferrable to embed it in the PCI host bridge QOSGraphObject.

Paolo
