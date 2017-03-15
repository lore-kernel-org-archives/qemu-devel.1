Received: from eggs.gnu.org ([2001:4830:134:3::10]:45296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co39E-0007yB-IF
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:15:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co399-000284-Kf
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:15:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co399-00027i-El
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:14:59 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-17-git-send-email-armbru@redhat.com>
	<b2d0adab-3200-c74a-4c1e-d4b5bbae7b6e@redhat.com>
Date: Wed, 15 Mar 2017 08:14:56 +0100
In-Reply-To: <b2d0adab-3200-c74a-4c1e-d4b5bbae7b6e@redhat.com> (Eric Blake's
	message of "Tue, 14 Mar 2017 12:31:56 -0500")
Message-ID: <87pohjroy7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 16/47] qapi2texi: Convert to
 QAPISchemaVisitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 03/13/2017 01:18 AM, Markus Armbruster wrote:
>> qapi2texi works with schema expression trees.  Such a tight coupling
>> to schema language syntax is not a good idea.  Convert it to the visitor
>> interface the other generators use.
>> 
>> No change to generated documentation.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi2texi.py | 228 ++++++++++++++++++++++++++-------------------------
>>  1 file changed, 118 insertions(+), 110 deletions(-)
>> 
>
>> +    def visit_object_type(self, name, info, base, members, variants):
>> +        doc = self.cur_doc
>> +        if not variants:
>> +            typ = 'Struct'
>> +        elif variants._tag_name:        # TODO unclean member access
>> +            typ = 'Flat Union'
>> +        else:
>> +            typ = 'Simple Union'
>
> Do we even want to document this distinction to the end user?

No, we don't.  '[PATCH for-2.9 29/47] qapi2texi: Use category "Object"
for all object types' takes care of it.

> Introspection managed to hide the difference by introducing the
> appropriate generated wrapper types that demonstrate the additional {}
> nesting in a way compatible with rewriting simple unions into flat
> unions.  If we don't explain the difference here, we can get rid of the
> unclean member access, but then again risk documentation that is not
> clear whether {} nesting is needed.
>
> I guess there's also the fact that for this patch, you intentionally
> tried to make no difference to the generated docs (good); so any tweaks
> to union output should be later patches anyways.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
