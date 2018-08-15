Received: from eggs.gnu.org ([2001:4830:134:3::10]:44856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fpord-0002Di-6I
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 02:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fporZ-0000eh-FY
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 02:01:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39878 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fporY-0000dg-Q1
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 02:00:57 -0400
References: <1534258018-22859-1-git-send-email-thuth@redhat.com>
	<1534258018-22859-3-git-send-email-thuth@redhat.com>
	<87a7pou95a.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <44875a85-ddcf-6a81-ca42-24fe9b268b93@redhat.com>
Date: Wed, 15 Aug 2018 08:00:53 +0200
MIME-Version: 1.0
In-Reply-To: <87a7pou95a.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/6] tests/device-introspection: Check that
 the qom-tree and qtree do not change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 08/14/2018 07:53 PM, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
[...]
>> @@ -115,10 +122,18 @@ static void test_one_device(const char *type)
>>  
>>      /*
>>       * Some devices leave dangling pointers in QOM behind.
>> -     * "info qom-tree" has a good chance at crashing then
>> +     * "info qom-tree" or "info qtree" have a good chance at crashing then.
>> +     * Also make sure that the tree did not change.
>>       */
>> -    qom_tree = hmp("info qom-tree");
>> -    g_free(qom_tree);
>> +    qom_tree_end = hmp("info qom-tree");
>> +    g_assert_cmpstr(qom_tree_start, ==, qom_tree_end);
>> +    g_free(qom_tree_start);
>> +    g_free(qom_tree_end);
>> +
>> +    qtree_end = hmp("info qtree");
>> +    g_assert_cmpstr(qtree_start, ==, qtree_end);
>> +    g_free(qtree_start);
>> +    g_free(qtree_end);
>>  }
>>  
>>  static void test_device_intro_list(void)
> 
> Output of "info qom-tree" depends on hash table iteration order, but
> that could almost be considered a feature here.

Currently, it seems to work fine. If we hit a false positive with
ordering later, we still can add some code for sorting the output, I guess?

 Thomas
