Received: from eggs.gnu.org ([2001:4830:134:3::10]:43321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fD5So-0007qh-7z
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fD5Sl-0001cy-4t
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:51:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58850 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fD5Sk-0001cW-VC
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:51:15 -0400
References: <20180430062536.49077-1-aik@ozlabs.ru>
	<20180430062536.49077-3-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <80d34e0f-b9e5-df5c-8464-0a15df26e1ca@redhat.com>
Date: Mon, 30 Apr 2018 11:51:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180430062536.49077-3-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v2 2/2] object: Handle objects with no
 parents
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

On 30/04/2018 08:25, Alexey Kardashevskiy wrote:
> At the moment object_get_canonical_path_component() crashes on assert()
> if the object does not have a parent. Usually it is not called for
> orphan objects but various HMP/QMP commands can do that (info mtree,
> qom-get).
> 
> This adds few more tests in object_get_canonical_path() to prevent QEMU
> from crashing.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  qom/object.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index 4677951..e0e300b 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1668,7 +1668,7 @@ gchar *object_get_canonical_path(Object *obj)
>      Object *root = object_get_root();
>      char *newpath, *path = NULL;
>  
> -    while (obj != root) {
> +    while (obj && obj->parent && obj != root) {
>          char *component = object_get_canonical_path_component(obj);
>  
>          if (path) {

I think the patch is a good idea, but as it is written it is incorrect,
because it will return an invalid canonical path.  You should return
NULL instead.

Also, checking both obj and obj->parent is unnecessary; if obj->parent
is NULL, obj will be NULL on the next iteration.

Thanks,

Paolo
