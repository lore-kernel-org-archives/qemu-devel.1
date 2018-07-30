Received: from eggs.gnu.org ([2001:4830:134:3::10]:40390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk1Hx-000515-4a
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 02:04:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk1Hs-0000w2-6D
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 02:04:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40984 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fk1Hs-0000vq-1e
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 02:04:08 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-14-armbru@redhat.com>
	<1c126eed-8b47-b61a-69d8-38176e1e586d@redhat.com>
Date: Mon, 30 Jul 2018 08:04:05 +0200
In-Reply-To: <1c126eed-8b47-b61a-69d8-38176e1e586d@redhat.com> (Eric Blake's
	message of "Fri, 27 Jul 2018 10:48:33 -0500")
Message-ID: <87d0v52rai.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 13/23] tests: Clean up string
 interpolation around qtest_qmp_device_add()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, thuth@redhat.com, f4bug@amsat.org

Eric Blake <eblake@redhat.com> writes:

> On 07/27/2018 10:13 AM, Markus Armbruster wrote:
>> Leaving interpolation into JSON to qmp() is more robust than building
>> QMP input manually, as explained in the commit before previous.
>>
>> qtest_qmp_device_add() and its wrappers interpolate into JSON as
>> follows:
>>
>> * qtest_qmp_device_add() interpolates members into a JSON object.
>>
>> * So do its wrappers qpci_plug_device_test() and usb_test_hotplug().
>>
>> * usb_test_hotplug() additionally interpolates strings and numbers
>>    into JSON strings.
>>
>> Clean them up:
>>
>> * Have qtest_qmp_device_add() take its extra device properties as
>>    arguments for for qdict_from_jsonf_nofail() instead of a string
>
> s/for for/for/

Fixing...

>>    containing JSON members.
>>
>> * Drop qpci_plug_device_test(), use qtest_qmp_device_add()
>>    directly.
>>
>> * Change usb_test_hotplug() parameter @port to string, to avoid
>>    interpolation.  Interpolate @hcd_id separately.
>>
>> Bonus: gets rid of a non-literal format string.  A step towards
>> compile-time format string checking without triggering
>> -Wformat-nonliteral.
>>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> +++ b/tests/ivshmem-test.c
>> @@ -420,19 +420,17 @@ static void test_ivshmem_server_irq(void)
>>   static void test_ivshmem_hotplug(void)
>>   {
>>       const char *arch = qtest_get_arch();
>> -    gchar *opts;
>>         qtest_start("");
>>   -    opts = g_strdup_printf("'shm': '%s', 'size': '1M'", tmpshm);
>> -
>> -    qpci_plug_device_test("ivshmem", "iv1", PCI_SLOT_HP, opts);
>> +    qtest_qmp_device_add("ivshmem",
>> +                         "iv1", "{'addr': %s, 'shm': '%s', 'size': '1M'}",
>
> Umm, how does this still pass?  You want 'shm':%s, not 'shm':'%s'.

Good catch.

It passes, because the value of "shm" is an arbitrary file name under
/dev/shm/.

> (We really want to assert that any % interpolations in our JSON parser
> are NOT embedded in '').
>
> With that error fixed,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
