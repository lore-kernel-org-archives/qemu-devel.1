Received: from eggs.gnu.org ([2001:4830:134:3::10]:48484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fpdkp-0002rF-JN
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fpdka-0005gD-90
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:09:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49898 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fpdkZ-0005eo-W3
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:09:00 -0400
References: <1534258018-22859-1-git-send-email-thuth@redhat.com>
	<1534258018-22859-6-git-send-email-thuth@redhat.com>
	<1d700466-d271-f1b6-d7e4-ea82608d984f@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <33446506-a101-69c3-9d31-c1b8ef8d8b32@redhat.com>
Date: Tue, 14 Aug 2018 17:43:07 +0200
MIME-Version: 1.0
In-Reply-To: <1d700466-d271-f1b6-d7e4-ea82608d984f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/6] net: Silence 'has no peer' messages in
 testing mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 08/14/2018 05:33 PM, Paolo Bonzini wrote:
> On 14/08/2018 16:46, Thomas Huth wrote:
>> When running qtests with -nodefaults, we are not interested in
>> these 'XYZ has no peer' messages.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  vl.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/vl.c b/vl.c
>> index 16b913f..7055df3 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -4559,11 +4559,10 @@ int main(int argc, char **argv, char **envp)
>>       * (2) CONFIG_SLIRP not set, in which case the implicit "-net nic=
"
>>       * sets up a nic that isn't connected to anything.
>>       */
>> -    if (!default_net) {
>> +    if (!default_net && (!qtest_enabled() || has_defaults)) {
>>          net_check_clients();
>>      }
>> =20
>=20
> Why does it have no peer?  Not a nack, just curiosity.

The machines which emulate an embedded system often always create a NIC
(since it is hard-wired on the board, not optional). But since there is
no back-end on the host side with "-nodefaults", the net_check_clients()
function complains in this case.

For example:

$ microblaze-softmmu/qemu-system-microblaze -nodefaults -S
qemu-system-microblaze: warning: nic xlnx.xps-ethernetlite.0 has no peer

 Thomas
