Received: from eggs.gnu.org ([209.51.188.92]:42929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gxAs3-0003U8-3d
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:28:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gxAs1-0007CA-T5
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:28:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gxAs1-0006Dv-It
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:28:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id h22so8907092wmb.0
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 05:27:28 -0800 (PST)
References: <20190215155709.15777-1-berrange@redhat.com>
	<20190215155709.15777-11-berrange@redhat.com>
	<81a05e66-016c-db53-c3f5-2607bb8c515e@redhat.com>
	<20190222122423.GR25234@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <23bcdd12-bcc6-f452-f1df-55bcbcd90bec@redhat.com>
Date: Fri, 22 Feb 2019 14:27:26 +0100
MIME-Version: 1.0
In-Reply-To: <20190222122423.GR25234@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 10/11] authz: add QAuthZPAM object type
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Hi Daniel,

On 2/22/19 1:24 PM, Daniel P. Berrangé wrote:
> On Fri, Feb 22, 2019 at 01:34:12AM +0100, Philippe Mathieu-Daudé wrote:
>> Hi Daniel,
>>
>> On 2/15/19 4:57 PM, Daniel P. Berrangé wrote:
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
> 
>>> +static bool qauthz_pam_is_allowed(QAuthZ *authz,
>>> +                                  const char *identity,
>>> +                                  Error **errp)
>>> +{
>>> +    QAuthZPAM *pauthz = QAUTHZ_PAM(authz);
>>> +    const struct pam_conv pam_conversation = { 0 };
>>> +    pam_handle_t *pamh = NULL;
>>> +    int ret;
>>> +
>>> +    trace_qauthz_pam_check(authz, identity, pauthz->service);
>>> +    ret = pam_start(pauthz->service,
>>> +                    identity,
>>> +                    &pam_conversation,
>>> +                    &pamh);
>>> +    if (ret != PAM_SUCCESS) {
>>> +        error_setg(errp, "Unable to start PAM transaction: %s",
>>> +                   pam_strerror(NULL, ret));

"In an error case is the content of pamh undefined."
So it is safer to use NULL here indeed.

>>> +        return false;
>>> +    }
>>> +
>>> +    ret = pam_acct_mgmt(pamh, PAM_SILENT);
>>> +    if (ret != PAM_SUCCESS) {
>>> +        error_setg(errp, "Unable to authorize user '%s': %s",
>>> +                   identity, pam_strerror(pamh, ret));
>>> +        goto cleanup;
>>> +    }
>>> +
>>> + cleanup:
>>> +    pam_end(pamh, ret);
>>> +    return ret == PAM_SUCCESS;

Hmm I find this fragile.

A 'cleanup' label means (to me) you expect someone to eventually add
more code around, and I'm worried someone add a pam_smth() call after
pam_acct_mgmt(), that sets ret to PAM_SUCCESS.

It looks safer to me to simply not use any label here (for the current
code, if it is extended, we'll see).

>>> +}
>>
>> I still need to digest this function (reading more about PAM).
> 
> FWIW there's reasonably good manpages 'pam(3)' and 'pam(8)' are
> starting points.

Easier inverted, first 'pam(8)' then 'pam(3)' ;)

Here I realize last time I checked 'pam(3)' was 17 years ago...

>>> @@ -2864,6 +2870,33 @@ else
>>>  fi
>>>  
>>>  
>>> +##########################################
>>> +# PAM probe
>>> +
>>> +if test "x$auth_pam" != "no"; then
>>
>> Either check "x$auth_pam" != "xno", or "$auth_pam" != "no" (the latter
>> seems to follow the style of this file).
>>
>> Currently this condition is always true, so the script always calls
>> compile_prog. And if an user has PAM locally installed, it is not
>> possible to not use it.
> 
> Opps, yes, did I say I hate shell :-)
> 
>>
>>> +    cat > $TMPC <<EOF
>>> +#include <security/pam_appl.h>
>>> +#include <stdio.h>
>>> +int main(void) {
>>> +   const char *service_name = "qemu";
>>> +   const char *user = "frank";
>>> +   const struct pam_conv *pam_conv = NULL;
>>> +   pam_handle_t *pamh = NULL;
>>> +   pam_start(service_name, user, pam_conv, &pamh);
>>> +   return 0;
>>> +}
>>> +EOF
>>> +    if compile_prog "" "-lpam" ; then
>>> +	auth_pam=yes
>>> +    else
>>> +	if test "$auth_pam" = "yes"; then
>>> +	    feature_not_found "PAM" "Install PAM development package"
>>> +	else
>>> +	    auth_pam=no
>>> +	fi
>>> +    fi
> 
> I notice some indentation damage here now due to tabs that I'll also
> fix.

OK.

If you agree on removing the 'cleanup' label in qauthz_pam_is_allowed(),
for the whole patch:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Regards,

Phil.

> 
> Regards,
> Daniel
> 
