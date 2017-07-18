Received: from eggs.gnu.org ([2001:4830:134:3::10]:33430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXXPB-0004wv-B5
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 14:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXXPA-0005HU-FC
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 14:39:33 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-11-git-send-email-armbru@redhat.com>
	<1aa2bff6-8798-cfd4-e969-b98064dd7d4c@redhat.com>
Date: Tue, 18 Jul 2017 20:39:25 +0200
In-Reply-To: <1aa2bff6-8798-cfd4-e969-b98064dd7d4c@redhat.com> (Eric Blake's
	message of "Tue, 18 Jul 2017 12:46:35 -0500")
Message-ID: <87d18xk2si.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.10 10/10] migration: Use JSON null
 instead of "" to reset parameter to default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 07/18/2017 08:41 AM, Markus Armbruster wrote:
>> migrate-set-parameters sets migration parameters according to is
>> arguments like this:
>> 
>> * Present means "set the parameter to this value"
>> 
>> * Absent means "leave the parameter unchanged"
>> 
>> * Except for parameters tls_creds and tls_hostname, "" means "reset
>>   the parameter to its default value
>> 
>> The first two are perfectly normal: presence of the parameter makes
>> the command do something.
>> 
>> The third one overloads the parameter with a second meaning.  The
>> overloading is *implicit*, i.e. it's not visible in the types.  Works
>> here, because "" is neither a valid TLS credentials ID, nor a valid
>> host name.
>> 
>> Pressing argument values the schema accepts, but are semantically
>> invalid, into service to mean "reset to default" is not general, as
>> suitable invalid values need not exist.  I also find it ugly.
>> 
>> To clean this up, we could add a separate flag argument to ask for
>> "reset to default", or add a distinct value to @tls_creds and
>> @tls_hostname.  This commit implements the latter: add JSON null to
>> the values of @tls_creds and @tls_hostname, deprecate "".
>> 
>> Because we're so close to the 2.10 freeze, implement it in the
>> stupidest way possible: have qmp_migrate_set_parameters() rewrite null
>> to "" before anything else can see the null.  The proper way to do it
>> would be rewriting "" to null, but that requires fixing up code to
>> work with null.  Add TODO comments for that.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>> +++ b/qapi-schema.json
>> @@ -116,6 +116,13 @@
>>  { 'command': 'qmp_capabilities' }
>>  
>>  ##
>> +# @StrOrNull:
>
> A little light on the documentation.

Care to suggest improvements?  I figure the schema is obvious enough
without any, but the generated documentation could perhaps use some.

[...]
