Received: from eggs.gnu.org ([2001:4830:134:3::10]:37052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dTZTg-0003fD-5D
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 16:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dTZTd-0002rl-1k
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 16:03:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dTZTc-0002pJ-Og
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 16:03:44 -0400
References: <1498745240-30658-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1498745240-30658-6-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170703113940.0e0415a2@nial.brq.redhat.com>
	<0efc917e-16d3-f01b-6fd8-a3bb71580bf4@ilande.co.uk>
	<20170707133320.2e0d741d@nial.brq.redhat.com>
	<20170707131300.GG10776@localhost.localdomain>
	<20170707165817.1a0103c1@nial.brq.redhat.com>
	<20170707150956.GZ12152@localhost.localdomain>
	<20170707201820.5db54aa1@Igors-MacBook-Pro.local>
	<20170707193029.GB12152@localhost.localdomain>
	<20170707195416.GK10776@localhost.localdomain>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <342ed63f-f353-23fb-a8b9-15a5d77ef22b@redhat.com>
Date: Fri, 7 Jul 2017 22:03:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170707195416.GK10776@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv7 5/6] fw_cfg: move qdev_init_nofail() from
 fw_cfg_init1() to callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com

On 07/07/17 21:54, Eduardo Habkost wrote:
> On Fri, Jul 07, 2017 at 04:30:29PM -0300, Eduardo Habkost wrote:
>> On Fri, Jul 07, 2017 at 08:18:20PM +0200, Igor Mammedov wrote:
>>> On Fri, 7 Jul 2017 12:09:56 -0300
>>> Eduardo Habkost <ehabkost@redhat.com> wrote:
>>>
>>>> On Fri, Jul 07, 2017 at 04:58:17PM +0200, Igor Mammedov wrote:
>>>>> On Fri, 7 Jul 2017 10:13:00 -0300
>>>>> "Eduardo Habkost" <ehabkost@redhat.com> wrote:
>>>> [...]
>>>>>> I don't disagree with adding the assert(), but it looks like
>>>>>> making fw_cfg_find() return NULL if there are multiple devices
>>>>>> can be useful for realize.
>>>>>>
>>>>>> In this case, it looks like Mark is relying on that in
>>>>>> fw_cfg_common_realize(): if multiple devices are created,
>>>>>> fw_cfg_find() will return NULL, and realize will fail.  This
>>>>>> sounds like a more graceful way to handle multiple-device
>>>>>> creation than crashing on fw_cfg_find().  This is the solution
>>>>>> used by find_vmgenid_dev()/vmgenid_realize(), BTW.
>>>>>
>>>>> I suspect that find_vmgenid_dev() works by luck as it could be
>>>>> placed only as /machine/peripheral-anon/foo1 or /machine/peripheral/foo2
>>>>>   object_resolve_partial_path() : machine
>>>>>            object_resolve_partial_path() : peripheral-anon => foo1
>>>>>            object_resolve_partial_path() : peripheral => foo2
>>>>>            if (found /* foo2 */) {
>>>>>                if (obj /* foo1 */) {
>>>>>                    return NULL;
>>>>
>>>> I don't think this is luck: object_resolve_partial_path() is
>>>> explicitly documented to always return NULL if multiple matches
>>>> are found, and I don't see any bug in its implementation that
>>>> would break that functionality.
>>>
>>> Maybe I'm reading it wrong, but consider following:
>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg460692.html
>>>
>>> it looks to me that using ambiguous argument is necessary for
>>> duplicate detection to work correctly.
>>
>> Oh, good catch, I think I see the bug now.  We need to write a
>> test case and fix that.
> 
> I could reproduce it with the following test case.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
> index 8e432e9..c320cff 100644
> --- a/tests/check-qom-proplist.c
> +++ b/tests/check-qom-proplist.c
> @@ -568,6 +568,29 @@ static void test_dummy_delchild(void)
>      object_unparent(OBJECT(dev));
>  }
>  
> +static void test_qom_partial_path(void)
> +{
> +    Object *root = object_get_objects_root();
> +    Object *o   = object_new(TYPE_DUMMY);
> +    Object *o1_1 = object_new(TYPE_DUMMY);
> +    Object *o1_2 = object_new(TYPE_DUMMY);
> +    Object *o2   = object_new(TYPE_DUMMY);
> +
> +    object_property_add_child(root, "o", o, &error_abort);
> +    object_property_add_child(o, "o1", o1_1, &error_abort);
> +    object_property_add_child(o, "o2", o1_2, &error_abort);
> +    object_property_add_child(root, "o2", o2, &error_abort);
> +
> +    g_assert(!object_resolve_path_type("", TYPE_DUMMY, NULL));
> +    g_assert(!object_resolve_path("o2", NULL));
> +    g_assert(object_resolve_path("o1", NULL) == o1_1);
> +
> +    object_unref(o);
> +    object_unref(o2);
> +    object_unref(o1_1);
> +    object_unref(o1_2);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
> @@ -585,6 +608,7 @@ int main(int argc, char **argv)
>      g_test_add_func("/qom/proplist/getenum", test_dummy_getenum);
>      g_test_add_func("/qom/proplist/iterator", test_dummy_iterator);
>      g_test_add_func("/qom/proplist/delchild", test_dummy_delchild);
> +    g_test_add_func("/qom/path/resolve/partial", test_qom_partial_path);
>  
>      return g_test_run();
>  }
> 

Meta comment: variable names like "o" and "l" are terrible (they look
like 0 and 1, dependent on your font). I suggest "obj".

Thanks
Laszlo
