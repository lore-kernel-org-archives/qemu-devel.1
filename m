Received: from eggs.gnu.org ([2001:4830:134:3::10]:53329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dmzYo-0006ah-J5
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dmzYl-00085M-C4
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:45:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dmzYl-00084w-6X
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:45:19 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <6f537126-f1a6-2159-d8f7-35d34b803dfa@redhat.com> (Thomas Huth's
	message of "Mon, 28 Aug 2017 18:10:09 +0200")
References: <20170823083901.852-1-quintela@redhat.com>
	<20170823083901.852-2-quintela@redhat.com>
	<6f537126-f1a6-2159-d8f7-35d34b803dfa@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 30 Aug 2017 11:45:07 +0200
Message-ID: <87a82h75jw.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] tests: Use real size for iov tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com, peterx@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>

Thomas Huth <thuth@redhat.com> wrote:
> On 23.08.2017 10:39, Juan Quintela wrote:
>> We were using -1 instead of the real size because the functions check
>> what is bigger, size in bytes or the size of the iov.  Recent gcc's
>> barf at this.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  tests/test-iov.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> While you're at it, could you maybe also adjust the comments in
> include/qemu/iov.h ? It currently says:
>
>  * It is okay to use very large value for `bytes' since we're
>  * limited by the size of the iovec anyway, provided that the
>  * buffer pointed to by buf has enough space.  One possible
>  * such "large" value is -1 (sinice size_t is unsigned),
>  * so specifying `-1' as `bytes' means 'up to the end of iovec'.

Haven't found this.  Fixing.

>
> ... and apparently -1 is not working anymore as expected. Maybe SIZE_MAX
> from stdint.h is a better choice?

Compiler get confused with it, because we have _new_ values, see the
warning on the cover, I *think* that in this one, the compiler is *kind*
of right. (*)

>  Thomas

Later, Juan.

(*) see the warning, I think that it gets a bit confused, but generaly,
    we are just abusing the interface, and anyways, we are using in real
    code the real size, and in the test, it was easy to change
    everything to the real size, so I think it is better just to remove
    *that* feature.
