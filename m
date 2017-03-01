Received: from eggs.gnu.org ([2001:4830:134:3::10]:33301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cix6m-0006vy-R5
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 00:47:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cix6l-0004Go-K8
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 00:47:28 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488317230-26248-1-git-send-email-armbru@redhat.com>
	<1488317230-26248-25-git-send-email-armbru@redhat.com>
	<cb582b14-93a2-e505-2bf0-004821ed36ff@redhat.com>
Date: Wed, 01 Mar 2017 06:47:19 +0100
In-Reply-To: <cb582b14-93a2-e505-2bf0-004821ed36ff@redhat.com> (Eric Blake's
	message of "Tue, 28 Feb 2017 16:56:15 -0600")
Message-ID: <87shmxwntk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 24/24] keyval: Support lists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, mdroth@linux.vnet.ibm.com, qemu-block@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/28/2017 03:27 PM, Markus Armbruster wrote:
>> Additionally permit non-negative integers as key components.  A
>> dictionary's keys must either be all integers or none.  If all keys
>> are integers, convert the dictionary to a list.  The set of keys must
>> be [0,N].
>> 
>
>> +static void test_keyval_parse_list(void)
>> +{
>> +    Error *err = NULL;
>> +    QDict *qdict, *sub_qdict;
>> +
>
>> +    /* Missing list indexes */
>> +    qdict = keyval_parse("list.2=lonely", NULL, &err);
>> +    error_free_or_abort(&err);
>> +    g_assert(!qdict);
>> +    qdict = keyval_parse("list.0=null,list.2=eins,list.02=zwei", NULL, &err);
>
> You have a negative test that covers when list.2 and list.02 map to the
> same thing (but we forgot list.1) [good], but no positive test of
> leading zeroes still resulting in a correct QList.  Seems like a
> reasonable followup patch during freeze (testsuite additions are freeze
> material, and I don't want to delay the pull request).

Can do a follow-up.

> At any rate, this one looks better than v1 at handling leading zero
> index duplication.
>
>>  /*
>> + * Convert @key to a list index.
>> + * Convert all leading digits to a (non-negative) number, capped at
>
> Maybe insert the word 'decimal', to make it obvious that 010 is index
> 10, not 8?

Can't hurt.

>> +/*
>> + * Listify @cur recursively.
>> + * Replace QDicts whose keys are all valid list indexes by QLists.
>> + * @key_of_cur is the list of key fragments leading up to @cur.
>> + * On success, return either @cur or its replacement.
>> + * On failure, store an error through @errp and return NULL.
>> + */
>> +static QObject *keyval_listify(QDict *cur, GSList *key_of_cur, Error **errp)
>> +{
>
>> +
>> +    /*
>> +     * Make a list from @elt[], reporting any missing elements.
>> +     * If we dropped an index >= nelt in the previous loop, this loop
>> +     * will run into the sentinel and report index @nelt missing.
>> +     */
>> +    list = qlist_new();
>> +    assert(!elt[nelt-1]);       /* need the sentinel to be null */
>> +    for (i = 0; i < MIN(nelt, max_index + 1); i++) {
>> +        if (!elt[i]) {
>> +            key = reassemble_key(key_of_cur);
>> +            error_setg(errp, "Parameter '%s%d' missing", key, i);
>> +            g_free(key);
>> +            g_free(elt);
>> +            QDECREF(list);
>> +            return NULL;
>
> If more than one gap exists, this only reports the first missing
> element; "any missing elements" implies that it reports all.  No
> different from our behavior on structs, where we only report one
> (random!) excess element or the first missing one in visit order, rather
> than all problems, so all that needs tweaking would be the comment.

The comment is indeed sligtly misleasing, I'll rephrase it.

Note that reporting all missing list members would require compression;
we don't "list.10000=oopsie" to produce 10000 lines of "Parameter
list.%d missing".

> Can all be done as followups, without invalidating the pull request.
