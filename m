Received: from eggs.gnu.org ([2001:4830:134:3::10]:52912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNlSw-0006if-1H
	for qemu-devel@nongnu.org; Tue, 29 May 2018 16:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNlSs-00025F-SF
	for qemu-devel@nongnu.org; Tue, 29 May 2018 16:43:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50778 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fNlSs-000257-Mx
	for qemu-devel@nongnu.org; Tue, 29 May 2018 16:43:30 -0400
References: <1527612092-65980-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1527612092-65980-2-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ed01b561-663c-bee7-0a1a-ecab8265912e@redhat.com>
Date: Tue, 29 May 2018 15:43:29 -0500
MIME-Version: 1.0
In-Reply-To: <1527612092-65980-2-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qapi: allow empty branches in flat
 unions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, mdroth@linux.vnet.ibm.com

On 05/29/2018 11:41 AM, Anton Nefedov wrote:
> It often happens that just a few discriminator values imply extra data in
> a flat union. Existing checks did not make possible to leave other values
> uncovered. Such cases had to be worked around by either stating a dummy
> (empty) type or introducing another (subset) discriminator enumeration.
> 
> Both options create redundant entities in qapi files for little profit.
> 
> With this patch it is not necessary anymore to add designated union
> fields for every possible value of a discriminator enumeration.
> 
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>   docs/devel/qapi-code-gen.txt                        |  7 ++++---
>   scripts/qapi/common.py                              | 11 ++++-------
>   scripts/qapi/types.py                               |  4 +++-
>   scripts/qapi/visit.py                               | 17 +++++++++++++----
>   tests/qapi-schema/flat-union-incomplete-branch.err  |  1 -
>   tests/qapi-schema/flat-union-incomplete-branch.exit |  2 +-
>   tests/qapi-schema/flat-union-incomplete-branch.out  | 14 ++++++++++++++

Generally, when converting a negative test to a positive test, I prefer 
to instead drop the negative test and put the positive test as part of 
tests/qapi-schema/qapi-schema-test.json - because that file has the 
additional coverage of proving that the compiler is still happy with the 
generated code (we don't compile any of the other positive tests).

>   7 files changed, 39 insertions(+), 17 deletions(-)
> 
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index b9b6eab..a3ea450 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -496,9 +496,10 @@ Resulting in these JSON objects:
>   
>   Notice that in a flat union, the discriminator name is controlled by
>   the user, but because it must map to a base member with enum type, the
> -code generator can ensure that branches exist for all values of the
> -enum (although the order of the keys need not match the declaration of
> -the enum).  In the resulting generated C data types, a flat union is
> +code generator ensures that branches match the existing values of the
> +enum. The order of the keys need not match the declaration of the enum.
> +The keys need not cover all possible enum values.

Maybe mention that omitted enum values are still valid branches that 
merely add no additional members to the data type.

> +In the resulting generated C data types, a flat union is
>   represented as a struct with the base members included directly, and
>   then a union of structures for each branch of the struct.
>   

Otherwise seems reasonable to me.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
