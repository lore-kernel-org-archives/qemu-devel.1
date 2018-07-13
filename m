Received: from eggs.gnu.org ([2001:4830:134:3::10]:42780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdrXN-00044A-Tl
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 02:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdrXN-0002H1-08
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 02:26:41 -0400
References: <1531409463-3843-1-git-send-email-thuth@redhat.com>
	<1531409463-3843-2-git-send-email-thuth@redhat.com>
	<20180712165224.GD31657@localhost.localdomain>
	<224a0bbb-9dbb-87eb-9e9b-1c82923010b5@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e034610d-9a1d-a8a5-ee92-b2e3f0ba2891@redhat.com>
Date: Fri, 13 Jul 2018 08:26:29 +0200
MIME-Version: 1.0
In-Reply-To: <224a0bbb-9dbb-87eb-9e9b-1c82923010b5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] qom/object: Add a new function
 object_initialize_as_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 12/07/2018 18:55, Thomas Huth wrote:
>>> +void object_initialize_as_child(Object *parentobj, const char *propname,
>>> +                                void *childobj, size_t size, const char *type,
>>> +                                Error **errp);
>> Why did you use void* instead of Object*?
> That's the same what object_initialize() is doing (see above). Otherwise
> all the callers have to cast their pointers with OBJECT() first.

Actually I had forgotten about object_new_with_props, which is very
similar to the new function above.  I think we should follow the model
and define the new function as

void object_initialize_with_props(Object *parent, const char *id,
                           void *childobj,
                           size_t size, const char *type,
                           Error **errp,
                           ...) QEMU_SENTINEL;
void object_initialize_with_propv(Object *parent, const char *id,
                           void *childobj,
                           size_t size, const char *type,
                           Error **errp,
                           va_list vargs);

I actually prefer Thomas's name (or maybe even
object_initialize_child/object_initialize_childv), but if we adopt it we
should also rename object_new_with_props and object_new_with_propv, for
consistency.

Thanks,

Paolo
