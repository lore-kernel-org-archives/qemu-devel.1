Received: from eggs.gnu.org ([2001:4830:134:3::10]:35193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dIAJD-0008A6-PH
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dIAJA-0006Fy-Jo
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:57:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dIAJA-0006EY-Am
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:57:48 -0400
References: <20170531193434.6918-1-david@redhat.com>
	<20170531193434.6918-3-david@redhat.com>
	<e70d08bd-bf75-4997-df7b-e64710046fc3@linux.vnet.ibm.com>
	<f1a8957a-9d13-efce-c0c4-b010ae4b6cd8@redhat.com>
	<e7465d88-84b3-8287-1e42-c5b60b514ef6@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <50081e98-fdbc-ac3b-3600-5fc1686f6eb7@redhat.com>
Date: Tue, 6 Jun 2017 10:57:44 +0200
MIME-Version: 1.0
In-Reply-To: <e7465d88-84b3-8287-1e42-c5b60b514ef6@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/2] s390x/cpumodel: improve defintion
 search without an IBC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, jjherne@linux.vnet.ibm.com, qemu-devel@nongnu.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, thuth@redhat.com, Aurelien Jarno <aurelien@aurel32.net>, rth@twiddle.net

> Your change makes a lot of sense, but ain't easy to understand IMHO.
> 
> Maybe integrating some of the discussion from above into the commit
> message would be helpful. Especially this assumption that the client code
> is fine with getting a more recent GA version (and anything influenced by
> it) if the ec_ga parameter is (basically) invalid, because ec_ga invalid
> means no IBC, and that (somehow) ensures the guest will be unaware of the
> picked GA (and everything affected by it)
> 
> I do understand that your patch is clearly superior to what we have now,
> but I'm sill not sure why are we picking the last and not the firs one
> with the matching type (and not necessarily matching ec_ga).  I guess the
> solution is to be sought along 'more "flexibility".  That would mean the
> GA does not matter for the guest, but matters for something else (QEMU,
> libvirt, I do not know).
> 
> But if it matters, then for some to me unknown reasons newer GA must be
> safe there too. Fact is (by picking the last one) the algorithm ain't
> stable against appending a new GA to the list in a new qemu version
> (that's why I assume it must be safe).

Identifying a more recent GA version just allows us to forward more
features to the guest (introduced by a new GA version), that's all.
Think of a GA version as a firmware update. Sooner or later, most
systems will be updated.

>From a customer point of view, it's better to detect a GA2 on a GA1 than
a GA1 on a GA2 ;) The guest will only be able to tell the difference if
there are actually new features around - which can only happen if you're
really on the next GA version.

> 
> Let me add one meta comment too. IMHO what makes the function hard to
> understand, is that we have a bunch of optional parameters, and that
> although this seems to be some sort of approximation problem (find the
> best good enough), the metric ain't obvious for somebody not to familiar
> with the problem domain (like me). AFAIU you are fixing the following
> problem domain (me). Seems that the metric implemented was sub-optimal:
> if parameters present {type}, absent {ec_ga} maybe present {gen,
> features}, then type is not honored appropriately.  One can probably
> figure out what's intended by understanding all the usages (which makes
> reviewing it demanding). For instance, you also refer to a particular
> usage in your title/subject (that is "model->def =
> s390_find_cpu_def(cpu_type, ibc_gen(unblocked_ibc),
> ibc_ec_ga(unblocked_ibc), NULL);" in target/s390x/kvm.c).

Actually, I thought that all relevant z/VM systems would properly
forward the IBC. By relevant, I am speaking about zEC12+. So I never saw
this while working on the CPU model.

We could split this function into multiple: find by (cpuid),
(cpuid,gen,ec_ga), (features), (gen,ec_ga,features). All without
optional parameters. But I doubt that this will result in better code,
especially on the caller side.

If you have an idea how to improve that piece of code, feel free to send
a cleanup.

Thanks for having a look!

> 
> Since I agree it's an improvement:
> 
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>


-- 

Thanks,

David
