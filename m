Received: from eggs.gnu.org ([2001:4830:134:3::10]:53966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duDR5-0000cz-P1
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:59:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duDR4-0007n4-UX
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:59:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duDR4-0007mO-PO
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:59:14 -0400
References: <20170918101709.30421-1-aik@ozlabs.ru>
	<20170918101709.30421-2-aik@ozlabs.ru>
	<c01622e7-3e6d-cf90-a28c-aa31b4857887@redhat.com>
	<2debed31-4c28-6dc3-b159-1fdc3fbf87f5@ozlabs.ru>
	<a85cbaf9-d7c7-403b-2dfc-886f9ddc0920@ozlabs.ru>
	<11f3ee38-7c70-41d8-0df1-774fbe95cfcb@redhat.com>
	<ad3f6254-ca71-aa98-9d70-d8131511a397@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d018b4ec-0052-94f8-fd2e-bcbc9b5573b3@redhat.com>
Date: Tue, 19 Sep 2017 09:59:10 +0200
MIME-Version: 1.0
In-Reply-To: <ad3f6254-ca71-aa98-9d70-d8131511a397@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v3 01/13] memory: Postpone flatview
 and dispatch tree building till all devices are added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org

On 19/09/2017 09:57, Alexey Kardashevskiy wrote:
>> We can also resolve "fake" aliases, obtained through a region with only
>> one subregion.
> I just do this now (will post soon):
> 
> 
> empty_view = generate_memory_topology(NULL);
> [...]
> 
> new_view = generate_memory_topology(physmr);
> 
> if (!new_view->nr) {
>     flatview_ref(empty_view);
>     flatview_unref(new_view);
>     new_view = empty_view;
> 
> [...]
> 
> g_hash_table_insert(views, physmr, new_view);
> 
> and that's it. For non empty FVs I need to render FVs anyway and for
> all-disabled/empty FVs it is really cheap so no big loss here.

Is that enough to get 1 shared FV for all bus master address spaces?  In
any case, your patches provide a very good infrastructure and further
optimization can be done easily on top.

Paolo
