Received: from eggs.gnu.org ([2001:4830:134:3::10]:40600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7gn8-0005QG-LV
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7gmw-0000VI-Ku
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:02:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g7gmu-0000TX-My
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:02:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id z3-v6so6017311wrr.13
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 06:01:59 -0700 (PDT)
References: <20180907075948.26917-1-marcandre.lureau@redhat.com>
	<20180907075948.26917-9-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <63cf2b66-07d1-0fd6-0920-381d5624c5da@redhat.com>
Date: Wed, 3 Oct 2018 15:01:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180907075948.26917-9-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 08/12] tests/qom-proplist: check
 properties are not listed multiple times
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 07/09/2018 09:59, Marc-André Lureau wrote:
> And factor out a common function used by the follow class properties
> iterator test.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/check-qom-proplist.c | 44 +++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
> index 0f6d9c1ce3..8e1b9c27f3 100644
> --- a/tests/check-qom-proplist.c
> +++ b/tests/check-qom-proplist.c
> @@ -520,32 +520,19 @@ static void test_dummy_getenum(void)
>  }
>  
>  
> -static void test_dummy_iterator(void)
> +static void test_dummy_prop_iterator(ObjectPropertyIterator *iter)
>  {
> -    Object *parent = object_get_objects_root();
> -    DummyObject *dobj = DUMMY_OBJECT(
> -        object_new_with_props(TYPE_DUMMY,
> -                              parent,
> -                              "dummy0",
> -                              &error_abort,
> -                              "bv", "yes",
> -                              "sv", "Hiss hiss hiss",
> -                              "av", "platypus",
> -                              NULL));
> -
> -    ObjectProperty *prop;
> -    ObjectPropertyIterator iter;
>      bool seenbv = false, seensv = false, seenav = false, seentype;
> +    ObjectProperty *prop;
>  
> -    object_property_iter_init(&iter, OBJECT(dobj));
> -    while ((prop = object_property_iter_next(&iter))) {
> -        if (g_str_equal(prop->name, "bv")) {
> +    while ((prop = object_property_iter_next(iter))) {
> +        if (!seenbv && g_str_equal(prop->name, "bv")) {
>              seenbv = true;
> -        } else if (g_str_equal(prop->name, "sv")) {
> +        } else if (!seensv && g_str_equal(prop->name, "sv")) {
>              seensv = true;
> -        } else if (g_str_equal(prop->name, "av")) {
> +        } else if (!seenav && g_str_equal(prop->name, "av")) {
>              seenav = true;
> -        } else if (g_str_equal(prop->name, "type")) {
> +        } else if (!seentype && g_str_equal(prop->name, "type")) {
>              /* This prop comes from the base Object class */
>              seentype = true;
>          } else {
> @@ -557,7 +544,24 @@ static void test_dummy_iterator(void)
>      g_assert(seenav);
>      g_assert(seensv);
>      g_assert(seentype);
> +}
> +
> +static void test_dummy_iterator(void)
> +{
> +    Object *parent = object_get_objects_root();
> +    DummyObject *dobj = DUMMY_OBJECT(
> +        object_new_with_props(TYPE_DUMMY,
> +                              parent,
> +                              "dummy0",
> +                              &error_abort,
> +                              "bv", "yes",
> +                              "sv", "Hiss hiss hiss",
> +                              "av", "platypus",
> +                              NULL));
> +    ObjectPropertyIterator iter;
>  
> +    object_property_iter_init(&iter, OBJECT(dobj));
> +    test_dummy_prop_iterator(&iter);
>      object_unparent(OBJECT(dobj));
>  }
>  
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
