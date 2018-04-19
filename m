Received: from eggs.gnu.org ([2001:4830:134:3::10]:41410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f96sq-0000KZ-B8
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:33:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f96sn-00010M-5x
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:33:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60132 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f96sm-00010E-W3
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:33:41 -0400
References: <20180329032149.44685-1-aik@ozlabs.ru>
	<bc4100f4-0a01-a526-c6ce-c2602a96e28a@redhat.com>
	<d8efb96c-75a0-86fd-3615-57e9099afb5c@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <75bf706c-d2f2-e715-5b07-b651881e0a5e@redhat.com>
Date: Thu, 19 Apr 2018 12:33:25 +0200
MIME-Version: 1.0
In-Reply-To: <d8efb96c-75a0-86fd-3615-57e9099afb5c@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] RFC: memory/hmp: Print owners/parents
 in "info mtree"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 19/04/2018 04:41, Alexey Kardashevskiy wrote:
> it just seems to
> be a real case and majority of object_get_canonical_path_component() users
> do not test the returned pointer.
> 
> ===================
> diff --git a/qom/object.c b/qom/object.c
> index 4677951..0c2d5c2 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1645,7 +1645,9 @@ gchar *object_get_canonical_path_component(Object *obj)
>      GHashTableIter iter;
> 
>      g_assert(obj);
> -    g_assert(obj->parent != NULL);

I agree but why wouldn't the caller have crashed anyway on this assertion?

> as QMP crashes QEMU with this:
> 
> {"execute": "qom-get", "arguments": {"path":
> "/machine/unattached/device[3]/smram[0]", "property": "container"}}
> 
> with the patch it returns:
> 
> {'return': '/<no-parent>/mem-container-smram[0]'}

The root cause of this is that the accelerator object is not added to
the QOM object tree.

Paolo
