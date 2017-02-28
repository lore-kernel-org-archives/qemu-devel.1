Received: from eggs.gnu.org ([2001:4830:134:3::10]:55620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciowZ-00047d-82
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:04:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciowY-0000Aa-1m
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:04:23 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
	<1488194450-28056-25-git-send-email-armbru@redhat.com>
	<20170228192543.GZ4090@noname.redhat.com>
	<c1efb07d-e5ab-b627-8cf7-1a0c364e7c86@redhat.com>
Date: Tue, 28 Feb 2017 22:04:11 +0100
In-Reply-To: <c1efb07d-e5ab-b627-8cf7-1a0c364e7c86@redhat.com> (Eric Blake's
	message of "Tue, 28 Feb 2017 14:06:20 -0600")
Message-ID: <878toqauyc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 24/24] keyval: Support lists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/28/2017 01:25 PM, Kevin Wolf wrote:
>> Am 27.02.2017 um 12:20 hat Markus Armbruster geschrieben:
>>> Additionally permit non-negative integers as key components.  A
>>> dictionary's keys must either be all integers or none.  If all keys
>>> are integers, convert the dictionary to a list.  The set of keys must
>>> be [0,N].
>>>
>
>>> @@ -34,16 +36,16 @@
>>>   *   doesn't have one, because R.a must be an object to satisfy a.b=1
>>>   *   and a string to satisfy a=2.
>>>   *
>>> - * Key-fragments must be valid QAPI names.
>>> + * Key-fragments must be valid QAPI names or consist only of digits.
>
>>>  /*
>>> + * Convert @key to a list index.
>>> + * Convert all leading digits to a (non-negative) number, capped at
>>> + * INT_MAX.
>>> + * If @end is non-null, assign a pointer to the first character after
>>> + * the number to *@end.
>>> + * Else, fail if any characters follow.
>>> + * On success, return the converted number.
>>> + * On failure, return a negative value.
>>> + * Note: since only digits are converted, no two keys can map to the
>>> + * same number, except by overflow to INT_MAX.
>>> + */
>>> +static int key_to_index(const char *key, const char **end)
>>> +{
>>> +    int ret;
>>> +    unsigned long index;
>>> +
>>> +    if (*key < '0' || *key > '9') {
>>> +        return -EINVAL;
>>> +    }
>
> So no leading whitespace, '+', or '-', even if strtoul would have
> allowed it.  Such names are also invalid as member id names.  (There's
> still the question if we want to allow arbitrary whitespace after
> between-key-value ',', and maybe even after between-key-segment '.'
> after this series, to make it easier to write strategically line-wrapped
> command lines - but that's an independent thing to be done on top).

Yes.

>>> @@ -137,8 +165,13 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
>>>      cur = qdict;
>>>      s = key;
>>>      for (;;) {
>>> -        ret = parse_qapi_name(s, false);
>>> -        len = ret < 0 ? 0 : ret;
>>> +        /* Want a key index (unless it's first) or a QAPI name */
>>> +        if (s != key && key_to_index(s, &end) >= 0) {
>>> +            len = end - s;
>>> +        } else {
>>> +            ret = parse_qapi_name(s, false);
>>> +            len = ret < 0 ? 0 : ret;
>>> +        }
>
> Does this mishandle keyval_parse(string, "0", err) - where we want to
> assert that the caller always passes only a valid id name for an
> implicit key?

Crashes and burns...

>>>          assert(s + len <= key_end);
>>>          if (!len || (s + len < key_end && s[len] != '.')) {

... right here (I tried):

>>>              assert(key != implied_key);
>>> @@ -205,6 +238,119 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
>>>      return s;
>>>  }
>>>  
>>> +static char *reassemble_key(GSList *key)
>>> +{
>>> +    GString *s = g_string_new("");
>>> +    GSList *p;
>>> +
>>> +    for (p = key; p; p = p->next) {
>>> +        g_string_prepend_c(s, '.');
>>> +        g_string_prepend(s, (char *)p->data);
>
> Should this use the canonical form of an index, even if the user spelled
> it with extra bytes like leading zero?

I feel it's best to echo it back to the user exactly how he wrote it, as
far as practical.

>>> +    /* Copy @cur's values to @elt[] */
>>> +    nelt = qdict_size(cur);
>>> +    elt = g_new0(QObject *, nelt);
>> 
>> This doesn't seem to be freed.
>> 
>>> +    for (ent = qdict_first(cur); ent; ent = qdict_next(cur, ent)) {
>>> +        index = key_to_index(ent->key, NULL);
>>> +        assert(index >= 0);
>>> +        /*
>>> +         * We iterate @nelt times.  Because the dictionary keys are
>>> +         * distinct, the indexes are also distinct (key_to_index()
>>> +         * ensures it).
>> 
>> Really? What about leading zeros?
>
> key_to_index() should be used to convert "01" and "1" into the same key
> when first computing the QDict during the initial parse; this post-pass
> should thus only see a single "1" key (last-one-wins semantics,
> regardless of the difference in spelling of the same index repeated on
> the command line).
