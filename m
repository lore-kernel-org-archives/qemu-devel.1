Received: from eggs.gnu.org ([2001:4830:134:3::10]:58907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fI71P-0006N8-Nw
	for qemu-devel@nongnu.org; Mon, 14 May 2018 02:31:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fI71M-0004t5-GA
	for qemu-devel@nongnu.org; Mon, 14 May 2018 02:31:47 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180423165126.15441-1-david@redhat.com>
	<20180423165126.15441-3-david@redhat.com>
	<20180504192635.GA4903@localhost.localdomain>
	<f2b567cb-8723-4e6d-b6ec-a6d97bffab10@redhat.com>
	<20180510175222.GV25013@localhost.localdomain>
Date: Mon, 14 May 2018 08:31:40 +0200
In-Reply-To: <20180510175222.GV25013@localhost.localdomain> (Eduardo Habkost's
	message of "Thu, 10 May 2018 14:52:22 -0300")
Message-ID: <87in7q3fzn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 02/11] machine: make MemoryHotplugState
 accessible via the machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Thu, May 10, 2018 at 06:57:32PM +0200, Paolo Bonzini wrote:
> [...]
>> > -    machine->device_memory = g_malloc(sizeof(*machine->device_memory));
>> > +    machine->device_memory = g_malloc0(sizeof(*machine->device_memory));
>> 
>> g_new0 since you are at it? :)
>
> Nice suggestion, but this was already merged.
>
> I think we have a Coccinelle script that should detect this?

Closest match is commit message b45c03f585e, referred to last in commit
bdd81addf40 (both predate scripts/coccinelle/).  However, that script
only rewrites patterns involving sizeof(T), such as

    g_malloc(sizeof(T) * n) -> g_new(T, n)

because those are obvious improvements.  It doesn't rewrite patterns
like

    T *v = g_malloc(sizeof(*v)) -> T *v = g_new(T, 1)

because whether those are improvements is debatable.

Feel free to apply them wherever you think they are enough of an
improvement to be worth the churn.  But I wouldn't apply them tree-write
without rough consensus "this is what we want going forward".
