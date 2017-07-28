Received: from eggs.gnu.org ([2001:4830:134:3::10]:56155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1db9Hg-00053S-N0
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1db9Hf-000897-Uo
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:42:44 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-10-eblake@redhat.com>
	<20170728130538.GQ12364@stefanha-x1.localdomain>
Date: Fri, 28 Jul 2017 19:42:33 +0200
In-Reply-To: <20170728130538.GQ12364@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Fri, 28 Jul 2017 14:05:38 +0100")
Message-ID: <87eft0lapi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 09/12] tests/libqos/pci: Clean up string
 interpolation into QMP input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, stefanha@redhat.com, qemu-devel@nongnu.org, "open list:virtio-blk" <qemu-block@nongnu.org>

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Tue, Jul 25, 2017 at 04:15:20PM -0500, Eric Blake wrote:
>> @@ -419,19 +420,18 @@ static void test_ivshmem_server_irq(void)
>>  static void test_ivshmem_hotplug(void)
>>  {
>>      const char *arch = qtest_get_arch();
>> -    gchar *opts;
>> +    QObject *extra_args = qobject_from_jsonf("{ 'shm': '%s', 'size': '1M' }",
>> +                                             tmpshm);
>
> Is there a difference between:
>
>   qobject_from_jsonf("{ 'shm': '%s' }", tmpshm);
>
> and:
>
>   qobject_from_jsonf("{ 'shm': %s }", tmpshm);
>
> ?
>
> Below you use %s instead of '%s'.

Yes.  %s interpolates a JSON string, enclosed in quotes, funny
characters quoted.  Thus, the former is wrong.  I screwed up the
conversion from g_strdup_printf().  Good catch!
