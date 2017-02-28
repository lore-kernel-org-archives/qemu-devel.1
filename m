Received: from eggs.gnu.org ([2001:4830:134:3::10]:36306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cil4G-0005IX-GX
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cil4B-0003wG-IH
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:56:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cil4B-0003vX-4V
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:55:59 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 333533B3D2
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 16:55:59 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
	<1488145424-14974-24-git-send-email-armbru@redhat.com>
	<02d73850-0c88-ee05-2c24-02f0129dd175@redhat.com>
Date: Tue, 28 Feb 2017 17:55:56 +0100
In-Reply-To: <02d73850-0c88-ee05-2c24-02f0129dd175@redhat.com> (Eric Blake's
	message of "Tue, 28 Feb 2017 10:09:46 -0600")
Message-ID: <8737eymezn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 23/26] qapi: Make input visitors detect
 unvisited list tails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/26/2017 03:43 PM, Markus Armbruster wrote:
>> Fix the design flaw demonstrated in the previous commit: new method
>> check_list() lets input visitors report that unvisited input remains
>> for a list, exactly like check_struct() lets them report that
>> unvisited input remains for a struct or union.
>> 
>> Implement the method for the qobject input visitor (straightforward),
>> and the string input visitor (less so, due to the magic list syntax
>> there).  The opts visitor's list magic is even more impenetrable, and
>> all I can do there today is a stub with a FIXME comment.  No worse
>> than before.
>
> Yeah, I know what you mean (having worked on all three visitors in prior
> patches).  The opts visitor is just painful.
>
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> 
>> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
>> index 2de6377..fe7b988 100644
>> --- a/hw/ppc/spapr_drc.c
>> +++ b/hw/ppc/spapr_drc.c
>> @@ -326,6 +326,11 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
>>                      return;
>>                  }
>>              }
>> +            visit_check_list(v, &err);
>> +            if (err) {
>> +                error_propagate(errp, err);
>> +                return;
>> +            }
>>              visit_end_list(v, NULL);
>
> This doesn't look right.  You want the visit_end_list() call to occur
> unconditionally, even when visit_check_list() fails, so as to free any
> resources allocated by the visitor.

Will fix.

>> +++ b/tests/test-string-input-visitor.c
>> @@ -160,17 +160,9 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
>>      /* Would be simpler if the visitor genuinely supported virtual walks */
>>      visit_start_list(v, NULL, (GenericList **)&res, sizeof(*res),
>>                       &error_abort);
>> -    tail = res;
>> -    visit_type_int64(v, NULL, &tail->value, &error_abort);
>> -    g_assert_cmpint(tail->value, ==, 0);
>> -    tail = (int64List *)visit_next_list(v, (GenericList *)tail, sizeof(*res));
>> -    g_assert(tail);
>> -    visit_type_int64(v, NULL, &tail->value, &error_abort);
>> -    g_assert_cmpint(tail->value, ==, 2);
>> -    tail = (int64List *)visit_next_list(v, (GenericList *)tail, sizeof(*res));
>> -    g_assert(tail);
>> +    visit_check_list(v, &err);
>
> You are still calling visit_check_list() after a partial visit, but why
> change from a 2/3 visit to a 0/3 visit?

Suspect it's just an editing accident.  I'll add it back.
