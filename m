Received: from eggs.gnu.org ([2001:4830:134:3::10]:55947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6aRF-00024S-Tw
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6aRF-0004Og-2O
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:30:49 -0400
References: <20180411163940.2523-1-kwolf@redhat.com>
	<20180411163940.2523-8-kwolf@redhat.com>
	<33c2ce2d-18d6-5479-19d4-3a1923cea3cb@redhat.com>
	<20180412095157.GA5004@localhost.localdomain>
	<f30ff8e9-4273-c01b-ae67-5784d5914c7a@redhat.com>
	<20180412111143.GB5004@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <569800ae-12f8-53f1-012a-50408700ba39@redhat.com>
Date: Thu, 12 Apr 2018 13:30:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180412111143.GB5004@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/19] block: Really pause block jobs on
 drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, famz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

On 12/04/2018 13:11, Kevin Wolf wrote:
>> Well, there is one gotcha: bdrv_ref protects against disappearance, bu=
t
>> bdrv_ref/bdrv_unref are not thread-safe.  Am I missing something else?
>
> Apart from the above, if we do an extra bdrv_ref/unref we'd also have
> to keep track of all the nodes that we've referenced so that we unref
> the same nodes again, even if the graph has changes.
>
> So essentially you'd be introducing a new list of BDSes that we have to
> manage and then check for every reachable node whether it's already in
> that list or not, and for every node in the list whether it's still
> reachable.

That would be a hash table (a set), not a list, so easy to check.  But
the thread-safety is a bigger issue.

The problem I have is that there is a direction through which I/O flows
(parent-to-child), so why can't draining follow that natural direction.
Having to check for the parents' I/O, while draining the child, seems
wrong.  Perhaps we can't help it, but I cannot understand the reason.

Paolo
