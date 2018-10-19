Received: from eggs.gnu.org ([2001:4830:134:3::10]:52991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDTMC-0001Mh-V2
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDTM0-0008HL-IP
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:54:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDTM0-0008Ew-AW
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:54:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id n1-v6so37115639wrt.10
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 04:54:08 -0700 (PDT)
References: <20181009130442.26296-1-berrange@redhat.com>
	<20181009130442.26296-11-berrange@redhat.com>
	<d8312d1b-4c21-65f7-72eb-380a91f4459f@redhat.com>
	<20181019110448.GM13722@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <77e4193e-9122-5f4c-23e0-2fc18ea5abb9@redhat.com>
Date: Fri, 19 Oct 2018 13:54:05 +0200
MIME-Version: 1.0
In-Reply-To: <20181019110448.GM13722@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 10/11] authz: add QAuthZPAM object type
 for authorizing using PAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 19/10/2018 13:04, Daniel P. Berrangé wrote:
> On Fri, Oct 19, 2018 at 12:02:57PM +0200, Philippe Mathieu-Daudé wrote:
>> On 09/10/2018 15:04, Daniel P. Berrangé wrote:
>>> From: "Daniel P. Berrange" <berrange@redhat.com>
>>>
>>> Add an authorization backend that talks to PAM to check whether the user
>>> identity is allowed. This only uses the PAM account validation facility,
>>> which is essentially just a check to see if the provided username is permitted
>>> access. It doesn't use the authentication or session parts of PAM, since
>>> that's dealt with by the relevant part of QEMU (eg VNC server).
>>>
>>> Consider starting QEMU with a VNC server and telling it to use TLS with
>>> x509 client certificates and configuring it to use an PAM to validate
>>> the x509 distinguished name. In this example we're telling it to use PAM
>>> for the QAuthZ impl with a service name of "qemu-vnc"
>>>
>>>  $ qemu-system-x86_64 \
>>>      -object tls-creds-x509,id=tls0,dir=/home/berrange/security/qemutls,\
>>>              endpoint=server,verify-peer=yes \
>>>      -object authz-pam,id=authz0,service=qemu-vnc \
>>>      -vnc :1,tls-creds=tls0,tls-authz=authz0
>>>
>>> This requires an /etc/pam/qemu-vnc file to be created with the auth
>>> rules. A very simple file based whitelist can be setup using
>>>
>>>   $ cat > /etc/pam/qemu-vnc <<EOF
>>>   account         requisite       pam_listfile.so item=user sense=allow file=/etc/qemu/vnc.allow
>>>   EOF
>>>
>>> The /etc/qemu/vnc.allow file simply contains one username per line. Any
>>> username not in the file is denied. The usernames in this example are
>>> the x509 distinguished name from the client's x509 cert.
>>>
>>>   $ cat > /etc/qemu/vnc.allow <<EOF
>>>   CN=laptop.berrange.com,O=Berrange Home,L=London,ST=London,C=GB
>>>   EOF
>>>
>>> More interesting would be to configure PAM to use an LDAP backend, so
>>> that the QEMU authorization check data can be centralized instead of
>>> requiring each compute host to have file maintained.
>>>
>>> The main limitation with this PAM module is that the rules apply to all
>>> QEMU instances on the host. Setting up different rules per VM, would
>>> require creating a separate PAM service name & config file for every
>>> guest. An alternative approach for the future might be to not pass in
>>> the plain username to PAM, but instead combine the VM name or UUID with
>>> the username. This requires further consideration though.
>>>
>>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>>> ---
>>>  authz/Makefile.objs     |   3 +
>>>  authz/pamacct.c         | 149 ++++++++++++++++++++++++++++++++++++++++
>>>  authz/trace-events      |   3 +
>>>  configure               |  37 ++++++++++
>>>  include/authz/pamacct.h | 100 +++++++++++++++++++++++++++
>>>  qemu-options.hx         |  35 ++++++++++
>>>  6 files changed, 327 insertions(+)
>>>  create mode 100644 authz/pamacct.c
>>>  create mode 100644 include/authz/pamacct.h
> 
> [snip]
> 
>> Since this one links another lib, can we have a simple unit test?
> 
> I would like to have been able to test this, but AFAICT, it is not
> possible to test without having the pam service config file added
> into /etc/pam.d/, which we obviously can't do from a unit test
> in QEMU :-(

It makes sens. Too bad.

Thanks,

Phil.

> 
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Regards,
> Daniel
> 
